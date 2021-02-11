EXEC = ttyFetch

SRC = src/*.cpp
INC = inc/*.hpp
INC_DIRS = -Isrc
UNITY_DIR= -IUnity
TEST_FILES = test/*

CC = g++
CFLAGS = -Wall -g -pthread # -Werror

.PHONY: clean 

all: $(EXEC)

$(EXEC): $(SRC)
	$(CC) $(CFLAGS) $(SRC) $(LIB) $(INC_DIRS) -o $(EXEC) -lavcodec -lavfilter
clean:
	@rm -v $(EXEC) 
