/* 
 * tcpserver.c - A simple TCP echo server 
 * usage: tcpserver <port>
 */

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <netdb.h>
#include <sys/types.h> 
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#define BUFSIZE 15

#if 0
/* 
 * Structs exported from in.h
 */

/* Internet address */
struct in_addr {
  unsigned int s_addr; 
};

/* Internet style socket address */
struct sockaddr_in  {
  unsigned short int sin_family; /* Address family */
  unsigned short int sin_port;   /* Port number */
  struct in_addr sin_addr;	 /* IP address */
  unsigned char sin_zero[...];   /* Pad to size of 'struct sockaddr' */
};

/*
 * Struct exported from netdb.h
 */

/* Domain name service (DNS) host entry */
struct hostent {
  char    *h_name;        /* official name of host */
  char    **h_aliases;    /* alias list */
  int     h_addrtype;     /* host address type */
  int     h_length;       /* length of address */
  char    **h_addr_list;  /* list of addresses */
}
#endif


struct data {
   uint16_t distance;
   uint16_t width;
   uint16_t done;
};

struct data *dat;

/*
 * error - wrapper for perror
 */
void error(char *msg) {
  perror(msg);
  exit(1);
}

void parse_rada_input(char *buf){

  char *params = strtok ( buf, "\n" );
  //printf("dist: %s\n", params);
  dat->distance = (uint16_t) strtol(params, (char **)NULL, 10);

  params = strtok ( NULL, "\n" );
  //printf("width: %s\n", params);
  dat->width = (uint16_t) strtol(params, (char **)NULL, 10);

  params = strtok ( NULL, "\n" );
  //printf("done: %s\n", params);
  if (params != NULL)
    dat->done = (uint16_t) strtol(params, (char **)NULL, 10);
}

int main(int argc, char **argv) {
  FILE *pFile;

  pFile=fopen("lidar_data.csv", "w");
  fprintf(pFile, "Distance,Width\n");

  int parentfd; /* parent socket */
  int childfd; /* child socket */
  
//  int parentfd_gopro; /* parent socket */
//  int childfd_gopro; /* child socket */

  char buf[BUFSIZE]; /* message buffer */
  //char send[2] = "1";


  dat = (struct data *) malloc(sizeof(struct data));
  dat->distance = 0;
  dat->width = 0;
  dat->done = 0;


  /* 
   * check command line arguments 
   */
  if (argc != 1) {
    fprintf(stderr, "usage: %s\n", argv[0]);
    exit(1);
  }
  
  /***************************************************/
  /* Create Parent Socket */
  int portno = 8080;
  int optval; /* flag value for setsockopt */
  struct sockaddr_in serveraddr; /* server's addr */

  /* 
   * socket: create the parent socket 
   */
  parentfd = socket(AF_INET, SOCK_STREAM, 0);
  if (parentfd < 0) 
    error("ERROR opening socket");

  /* setsockopt: Handy debugging trick that lets 
   * us rerun the server immediately after we kill it; 
   * otherwise we have to wait about 20 secs. 
   * Eliminates "ERROR on binding: Address already in use" error. 
   */
  optval = 1;
  setsockopt(parentfd, SOL_SOCKET, SO_REUSEADDR, 
	     (const void *)&optval , sizeof(int));

  /*
   * build the server's Internet address
   */
  bzero((char *) &serveraddr, sizeof(serveraddr));

  /* this is an Internet address */
  serveraddr.sin_family = AF_INET;

  /* let the system figure out our IP address */
  serveraddr.sin_addr.s_addr = htonl(INADDR_ANY);

  /* this is the port we will listen on */
  serveraddr.sin_port = htons((unsigned short)portno);

  /* 
   * bind: associate the parent socket with a port 
   */
  if (bind(parentfd, (struct sockaddr *) &serveraddr, 
	   sizeof(serveraddr)) < 0) 
    error("ERROR on binding");

  /* 
   * listen: make this socket ready to accept connection requests 
   */
  if (listen(parentfd, 5) < 0) /* allow 5 requests to queue up */ 
    error("ERROR on listen");
  
  /* End Create Parent Socket */
  /***************************************************/
 
  while (1) {
    
    /***************************************************/
    /* Create child socket */
    int clientlen; /* byte size of client's address */
    struct sockaddr_in clientaddr; /* client addr */
    struct hostent *hostp; /* client host info */
    char *hostaddrp; /* dotted decimal host addr string */

    /* 
     * main loop: wait for a connection request, echo input line, 
     * then close connection.
     */
    clientlen = sizeof(clientaddr);

    /* 
     * accept: wait for a connection request 
     */
    childfd =  accept(parentfd, (struct sockaddr *) &clientaddr, (socklen_t * __restrict__) &clientlen);
    if (childfd < 0) 
      error("ERROR on accept");

    /* 
     * gethostbyaddr: determine who sent the message 
     */
    hostp = gethostbyaddr((const char *)&clientaddr.sin_addr.s_addr, 
	  sizeof(clientaddr.sin_addr.s_addr), AF_INET);
    if (hostp == NULL)
      error("ERROR on gethostbyaddr");
    hostaddrp = inet_ntoa(clientaddr.sin_addr);
    if (hostaddrp == NULL)
      error("ERROR on inet_ntoa\n");
    printf("server established connection with %s (%s)\n", 
      hostp->h_name, hostaddrp);
      
    /* End create child socket */
    /***************************************************/
        
    /***************************************************/
    /* Receive data from rada */
    int n; /* message byte size */

    /* 
     * read: read input string from the rada
     */
    bzero(buf, BUFSIZE);
    n = read(childfd, buf, BUFSIZE);

    if (n < 0) 
      error("ERROR reading from socket");

    /* End Receive data from arduino */
    /***************************************************/
    
    char *buff = malloc(BUFSIZE * sizeof(char));
    strcpy(buff, buf);
    /*
     * parse data received from the arduino
     */
    parse_rada_input(buff);

    if (dat->done == 1)
      break;
    
    /*
     * check parse results
     */
    printf("distance: %d\nwidth: %d\n", dat->distance, dat->width );
    fprintf(pFile, "%d,%d\n", dat->distance, dat->width);
    /*
     * Output LiDAR data to file
     */


    /* 
     * write: tell rada to reconnect to the gopro
     */
/*    n = write(childfd, send, strlen(send));
    if (n < 0) 
      error("ERROR writing to socket");
*/
      close(childfd);
  } // end while loop

  fclose(pFile);
} // end main
