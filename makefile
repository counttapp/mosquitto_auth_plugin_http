CC=gcc
MOSQUITTO=../mosquitto
INC=-I. -I$(MOSQUITTO)/lib -I$(MOSQUITTO)/src
CFLAGS=-Wall -fpic -DMQAP_DEBUG

LIBS=-lcurl
OBJ=mosquitto_auth_plugin_http.o adcmb.o
EXE=mosquitto_auth_plugin_http.so

.c.o:
	$(CC) $(CFLAGS) $(INC) -c $<

all: 	plugin 

plugin: $(OBJ)
	$(CC) -shared -o $(EXE) $(OBJ) $(LIBS)


clean:
	rm -f *.so *.o
