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

#define BUFSIZE 8

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
   uint32_t distance;
   uint32_t width;
};

struct data *dat;

/*
 * error - wrapper for perror
 */
void error(char *msg) {
  perror(msg);
  exit(1);
}

void parse_arduino_input(char *buf){
  uint32_t dist;
  uint32_t width;
  
  dist = (uint32_t) (buf[3] << 24);
  dist = (uint32_t) dist | (buf[2] << 16);
  dist = (uint32_t) dist | (buf[1] << 8);
  dist = (uint32_t) dist | buf[0];
  dat->distance = dist;

  width = (uint32_t) (buf[7] << 24);
  width = (uint32_t) width | (buf[6] << 16);
  width = (uint32_t) width | (buf[5] << 8);
  width = (uint32_t) width | buf[4];
  dat->width = width;
}

int main(int argc, char **argv) {
  int parentfd_arduino; /* parent socket */
  int childfd_arduino; /* child socket */
  
//  int parentfd_gopro; /* parent socket */
//  int childfd_gopro; /* child socket */

  char buf[BUFSIZE]; /* message buffer */
  char send[1];


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
  int parentfd;
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
  
  parentfd_arduino = parentfd;
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
    childfd_arduino =  accept(parentfd_arduino, (struct sockaddr *) &clientaddr, (socklen_t * __restrict__) &clientlen);
    if (childfd_arduino < 0) 
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
    /* Receive data from arduino */
    int n; /* message byte size */
 printf("before read\n");
 fflush(stdout);
    /* 
     * read: read input string from the arduino
     */
    bzero(buf, BUFSIZE);
    n = read(childfd_arduino, buf, BUFSIZE);
printf("after read\n");
fflush(stdout);
    if (n < 0) 
      error("ERROR reading from socket");
    printf("received child data\n");
    fflush(stdout);
    /* End Receive data from arduino */
    /***************************************************/
    
    /*
     * parse data received from the arduino
     */
    parse_arduino_input(buf);
    
    printf("parsed child data\n");
    /*
     * check parse results
     */
    printf("distance: %d\nwidth: %d\n", dat->distance, dat->width );
    
    /*
     * connect to the gopro
     */
    //parse_arduino_input(n, buf);
    
    /*
     * get pictures off gopro
     */
    
    
    /*
     * delete pictures off gopro
     */
    
    
    /*
     * disconnect gopro
     */
    
    

    /* 
     * write: tell arduino to reconnect to the gopro
     */
    n = write(childfd_arduino, send, strlen(send));
    if (n < 0) 
      error("ERROR writing to socket");

    close(childfd_arduino);
  } // end while loop
} // end main
