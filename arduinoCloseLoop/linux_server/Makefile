CC = gcc
ARGS = -Wall

all: post tcpclient serial

post: post.c
	$(CC) $(ARGS) -o post post.c

tcpclient: tcpclient.c
	$(CC) $(ARGS) -o tcpclient tcpclient.c
	
serial: serial.c
	$(CC) $(ARGS) -o serial serial.c

clean:
	rm -f *.o post tcpclient serial *~
