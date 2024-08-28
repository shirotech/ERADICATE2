CC=g++
CDEFINES=-DCL_TARGET_OPENCL_VERSION=120
SOURCES=Dispatcher.cpp eradicate2.cpp hexadecimal.cpp ModeFactory.cpp Speed.cpp sha3.cpp
OBJECTS=$(SOURCES:.cpp=.o)
EXECUTABLE=create2

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	LDFLAGS=-framework OpenCL
	CFLAGS=-c -std=c++20 -Wall -mmmx -march=native -O3
else
	LDFLAGS=-s -lOpenCL -mcmodel=large
	CFLAGS=-c -std=c++20 -Wall -mmmx -march=native -O3 -mcmodel=large
endif

all: $(SOURCES) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@

.cpp.o:
	$(CC) $(CFLAGS) $(CDEFINES) $< -o $@

clean:
	rm -rf *.o $(EXECUTABLE)
