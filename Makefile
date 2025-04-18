# Compiler to use
CC = g++

# Compiler flags
CFLAGS = -Wall -g

# Include directories
INCLUDES = -I./includes/glad/include -I./includes -I./includes/glm

# Source files
SOURCES = $(filter-out section1.cpp, $(wildcard *.cpp)) includes/glad/src/glad.c

# Output executable
TARGET = main

# Libraries to link
LIBS = -lglfw -lGL -lX11 -lpthread -lXrandr -lXi -ldl

OBJECTS = $(SOURCES:.c=.o)
OBJECTS := $(OBJECTS:.cpp=.o)

# Default target
all: $(TARGET)

# Link object files to create executable
$(TARGET): $(OBJECTS)
	$(CC) $^ -o $@ $(LIBS)

# Compile source files to object files
%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

%.o: %.cpp
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

# Clean up
clean:
	rm -f $(TARGET) *.o glad/src/*.o

# Phony targets
.PHONY: all clean
