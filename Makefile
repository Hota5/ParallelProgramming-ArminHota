CC = gcc
CFLAGS = -Wall -Wextra -g -std=c99
TARGET = Task1
SOURCE = Task1.c
FIX_TARGET = Task1-fix
FIX_SOURCE = Task1-fix.c

all: $(TARGET) $(FIX_TARGET)

$(TARGET): $(SOURCE)
	$(CC) $(CFLAGS) -o $(TARGET) $(SOURCE)

$(FIX_TARGET): $(FIX_SOURCE)
	$(CC) $(CFLAGS) -o $(FIX_TARGET) $(FIX_SOURCE)

run: $(TARGET)
	./$(TARGET)

valgrind: $(TARGET)
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./$(TARGET) 5

valgrind-simple: $(TARGET)
	valgrind --tool=memcheck --leak-check=yes ./$(TARGET) 5

run-fix: $(FIX_TARGET)
	./$(FIX_TARGET)

valgrind-fix: $(FIX_TARGET)
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./$(FIX_TARGET) 5

clean:
	rm -f $(TARGET) $(FIX_TARGET)
