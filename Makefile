SYS			:=	$(shell gcc -dumpmachine)
CC			=	g++

TARGET		=	libweb_socket.a

SOURCES		=	\
						WebSocket.cpp \
						base64/base64.cpp \
						sha1/sha1.cpp \
						sha1/sha.cpp

INSTALL_DIR	=	./

INCLUDE += -I../

CPPFLAGS += -g
CPPFLAGS += -D_REENTRANT -O2 -std=c++17 -Wall -Wextra -Wfloat-equal -m64

OBJECTS	:= $(SOURCES:.cpp=.o)

all: $(OBJECTS)
	rm -rf core.*
	ar rcv $(TARGET) $(OBJECTS)

clean:
	rm -rf $(TARGET) $(OBJECTS)

install: all
	cp $(TARGET) $(INSTALL_DIR)

.c.o: $(.cpp.o)
.cpp.o:
	$(CC) $(INCLUDE) $(CPPFLAGS) -c $< -o $@


