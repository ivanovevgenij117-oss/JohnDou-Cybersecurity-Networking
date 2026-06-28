all: s21_cat test

s21_cat:
	gcc -Wall -Wextra -Werror s21_cat.c -o s21_cat

test:
	bash ../test/s21_cat_test.sh

clean:
	rm -f s21_cat

rebuild: clean all
