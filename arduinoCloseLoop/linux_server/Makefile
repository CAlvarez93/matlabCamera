CC = gcc
ARGS = -Wall

all: tcpserver tcpclient serial

tcpserver: tcpserver.c
	$(CC) $(ARGS) -o tcpserver tcpserver.c

tcpclient: tcpclient.c
	$(CC) $(ARGS) -o tcpclient tcpclient.c
	
serial: serial.c
	$(CC) $(ARGS) -o serial serial.c

clean:
	rm -f *.o tcpserver tcpclient serial *~
