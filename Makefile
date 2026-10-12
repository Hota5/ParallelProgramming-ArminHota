CC = gcc
CFLAGS = -Wall -Wextra -g -std=c99
TARGET = Task1
SOURCE = Task1.c

all: $(TARGET)

$(TARGET): $(SOURCE)
	$(CC) $(CFLAGS) -o $(TARGET) $(SOURCE)

valgrind: $(TARGET)
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./$(TARGET)

clean:
	rm -f $(TARGET)

.PHONY: all debug valgrind valgrind-simple clean
