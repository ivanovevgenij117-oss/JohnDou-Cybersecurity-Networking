all: s21_grep test

s21_grep:
	gcc -Wall -Wextra -Werror s21_grep.c -o s21_grep

test:
	bash ../test/s21_grep_test.sh

clean:
	rm -f s21_grep

rebuild: clean all
