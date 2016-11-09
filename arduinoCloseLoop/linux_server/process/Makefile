CC = gcc
ARGS = -Wall

all: tcpserver tcpclient

tcpserver: tcpserver.c
	$(CC) $(ARGS) -o tcpserver tcpserver.c

tcpclient: tcpclient.c
	$(CC) $(ARGS) -o tcpclient tcpclient.c

clean:
	rm -f *.o tcpserver tcpclient *~
