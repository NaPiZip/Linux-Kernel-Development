CC=gcc
CFLAGS=-std=c89 -Wpedantic -Wall -O2


.c.o: 
	$(CC) $(CFLAGS) -c $<
	
forking: forking.o
	$(CC) -o $@ $^ $(CFLAGS)
	

.PHONY: clean

clean:
	rm -f *.o forking
