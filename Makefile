CC=gcc
MOSQUITTO=${BUILD_DIR}/mosquitto-${MOSQUITTO_VERSION}
INC=-I. -I$(MOSQUITTO)/lib -I$(MOSQUITTO)/src
override CFLAGS += -Wall -fpic -DMQAP_DEBUG

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
