CC = gcc
CP = g++
ARGS = -Wall

all: get_pic post tcpclient serial

get_pic: get_pic.cpp
	$(CP) $(ARGS) -o get_pic -lcurl get_pic.cpp

post: post.c
	$(CC) $(ARGS) -o post post.c

tcpclient: tcpclient.c
	$(CC) $(ARGS) -o tcpclient tcpclient.c
	
serial: serial.c
	$(CC) $(ARGS) -o serial serial.c

clean:
	rm -f *.o get_pic post tcpclient serial *~
