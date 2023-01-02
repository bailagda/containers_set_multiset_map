CC=gcc
CFLAGS=-std=c++20 -g -cpp
FLAGS_LIBA= -lgtest -lstdc++ -lpthread
SRC= *.hpp
TEST= test_assotiative_cont.cpp
# LIBA=s21_matrix.c s21_matrix.h

OBJ=$(patsubst %.cpp, %.o, $(SRC))
HEADER=s21_containers.hpp s21_containers_extra.hpp
# NAME=s21_containers.a

.PHONY: all build s21_containers test report clean m 

all: build

build: 
	$(CC) $(CFLAGS) $(HEADER) $(SRC) -o s21_containers.a 

s21_containers: build

# s21_containers.a : $(OBJ)
# 	ar rcs $@ $(OBJ)
# %.o : %.cc
# 	$(CC) $(CFLAGS) -cc $< -o $@
# gcc -cpp -std=c++17 test_assotiative_cont.cpp s21_containers.hpp -lgtest -lstdc++ -lpthread
test:
	$(CC) $(CFLAGS) $(SRC) $(TEST) $(FLAGS_LIBA) -o g_test
	./g_test

report: clean
	$(CC) --coverage $(TEST) $(SRC) $(FLAGS_LIBA) -o g_test
	chmod +x *
	./g_test
	lcov -t "gcov_test" -o gcov_test.info --no-external -c -d .
	genhtml -o report/ gcov_test.info
	open ./report/index.html


clean:
	rm -rf *.gch *.out *.o *.a m *.gcda *.gcdo *.gcno *.dSYM coverage_report gcov_test g_test *.html report

m:
	@g++ -cpp -std=c++17 -g *.hpp m.cpp
	@./a.out
