/* 
 * tcpclient.c - A simple TCP client
 * usage: tcpclient <host> <port>
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h> 

#define BUFSIZE 8

/* 
 * error - wrapper for perror
 */
void error(char *msg) {
    perror(msg);
    exit(0);
}

int main(int argc, char **argv) {
    int sockfd, portno, n;
    struct sockaddr_in serveraddr;
    struct hostent *server;
    char *hostname;
    char buf[BUFSIZE];
printf("start");
fflush( stdout );
    /* check command line arguments */
    if (argc != 1) {
       fprintf(stderr,"usage: %s\n", argv[0]);
       exit(0);
    }
    //hostname = "b01-1.nat.iastate.edu";
    hostname = "localhost";
    portno = 8080;
printf("creating socket\n");
fflush( stdout );
    /* socket: create the socket */
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) 
        error("ERROR opening socket");
printf("getting host name\n");
fflush( stdout );
    /* gethostbyname: get the server's DNS entry */
    server = gethostbyname(hostname);
    if (server == NULL) {
        fprintf(stderr,"ERROR, no such host as %s\n", hostname);
        exit(0);
    }
printf("building server internet address\n");
fflush( stdout );
    /* build the server's Internet address */
    bzero((char *) &serveraddr, sizeof(serveraddr));
    serveraddr.sin_family = AF_INET;
    bcopy((char *)server->h_addr, 
	  (char *)&serveraddr.sin_addr.s_addr, server->h_length);
    serveraddr.sin_port = htons(portno);

    printf("about to connect to server\n");
fflush( stdout );
    /* connect: create a connection with the server */
    if (connect(sockfd, (const struct sockaddr *) &serveraddr, sizeof(serveraddr)) < 0) 
      error("ERROR connecting");

    printf("connected to server\n");
fflush( stdout );
    /* get distance/width */
    bzero(buf, BUFSIZE);
    uint32_t dist = 0x0050;
    uint32_t width = 0x1150;
/*
    buf[0] = (dist >> 24) & 0xFF;
    buf[1] = (dist >> 16) & 0xFF;
    buf[2] = (dist >> 8) & 0xFF;
    buf[3] = dist & 0xFF;
    buf[4] = (width >> 24) & 0xFF;
    buf[5] = (width >> 16) & 0xFF;
    buf[6] = (width >> 8) & 0xFF;
    buf[7] = width & 0xFF;
    
    printf("made buf\n");
fflush( stdout );

*/
strcpy(buf, "abcde");

    /* send the message line to the server */
    n = write(sockfd, buf, strlen(buf));
    if (n < 0) 
      error("ERROR writing to socket\n");

    printf("wrote buf to server\n");
fflush( stdout );
    /* print the server's reply */
    bzero(buf, BUFSIZE);
    n = read(sockfd, buf, BUFSIZE);
    if (n < 0) 
      error("ERROR reading from socket");
    printf("Echo from server: %s\n", buf);
    close(sockfd);
    return 0;
}
