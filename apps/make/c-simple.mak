#
# simple C program build
#
CC=gcc
CFLAGS=-g
RM=rm -f

default: all

all: build

build: hello.c
	$(CC) $(CFLAGS) -o hello hello.c

clean:
	$(RM) hello
