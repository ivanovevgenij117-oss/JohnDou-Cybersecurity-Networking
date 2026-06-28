#ifndef S21_GREP_H
#define S21_GREP_H

#include <getopt.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define buff_size 999999

struct flags {
  int c, e, f, h, i, l, n, o, s, v;
};

void grep_main(struct flags *flag, int argc, char **argv, char *temp);
int pattFromfile(char *pattern, char *temp);
void grep_file(struct flags *flag, char *pattern, char *file);
void filework(struct flags *flag, FILE *fp, regex_t reg, char *file);

#endif
