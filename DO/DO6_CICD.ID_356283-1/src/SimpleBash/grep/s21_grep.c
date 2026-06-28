#include "s21_grep.h"

int main(int argc, char *argv[]) {
  struct flags flag = {0};
  char pattern[buff_size] = {0};

  int opt = 0;
  int countE = 0;

  while ((opt = getopt(argc, argv, "e:f:lcnhovis:")) != -1) {
    switch (opt) {
      case 'c':  // вывод Количества строк с искомым паттерном
        flag.c = 1;
        break;
      case 'e':  // этот флаг задает паттерны
        flag.e = 1;
        if (!countE) snprintf(pattern, buff_size, "%s", optarg);
        if (countE) {
          strcat(pattern, "|");
          strncat(pattern, optarg, buff_size - strlen(pattern) - 1);
        }
        countE++;
        break;
      case 'f':  // паттерны из файла
        flag.f = 1;
        snprintf(pattern, buff_size, "%s", optarg);
        break;
      case 'h':  // совпадающие строки без имени файла
        flag.h = 1;
        break;
      case 'i':  // игнор регистра
        flag.i = 1;
        break;
      case 'l':  // вывод имен файлов с искомым паттерном
        flag.l = 1;
        break;
      case 'n':  // номер строки в файле
        flag.n = 1;
        break;
      case 'o':  // вывод только совпадающей части
        flag.o = 1;
        break;
      case 's':  // подавление ошибок вывода файлов
        flag.s = 1;
        break;
      case 'v':  // инверсия поиска
        flag.v = 1;
        break;
      default:
        fprintf(stderr, "Unknown option '%c'\n", opt);
        exit(EXIT_FAILURE);
    }
  }

  if (argc >= 3) grep_main(&flag, argc, argv, pattern);

  return 0;
}

void grep_main(struct flags *flag, int argc, char **argv, char *temp) {
  char patMas[buff_size] = {0};
  int pFf = 0;

  if (!flag->f && !flag->e) snprintf(patMas, buff_size, "%s", argv[optind++]);
  if (flag->f) pFf = pattFromfile(patMas, temp);
  if (!flag->f && flag->e) snprintf(patMas, buff_size, "%s", temp);

  if (pFf != -1) {
    int file_c = (argc - optind > 1) ? 1 : 0;

    for (int count = optind; count < argc; count++) {
      if (file_c && !flag->h && !flag->l) printf("%s:", argv[count]);
      grep_file(flag, patMas, argv[count]);
    }
  }
}

int pattFromfile(char *pattern, char *temp) {
  FILE *fp;
  fp = fopen(temp, "r");
  int i = 0;

  if (fp == NULL) {
    i = -1;
  } else {
    int ch;
    while ((ch = fgetc(fp)) != EOF) {
      if (ch == 13 || ch == 10) pattern[i++] = '|';
      if (ch != 13 && ch != 10) pattern[i++] = ch;
    }

    if (pattern[i - 1] == '|') pattern[i - 1] = '\0';
    fclose(fp);
  }

  return (i == -1) ? -1 : (i + 1);
}

void grep_file(struct flags *flag, char *pattern, char *file) {
  int cflags = (flag->i) ? REG_ICASE | REG_EXTENDED : REG_EXTENDED;
  regex_t reg;
  FILE *fp;
  fp = fopen(file, "r");

  if (fp == NULL && !flag->s) {
    fprintf(stderr, "grep: %s: No such file or directory\n", file);
  } else if (fp == NULL) {
  } else {
    regcomp(&reg, pattern, cflags);
    filework(flag, fp, reg, file);
    regfree(&reg);
    fclose(fp);
  }
}

void filework(struct flags *flag, FILE *fp, regex_t reg, char *file) {
  char text[buff_size] = {0};
  regmatch_t pmatch[1];
  int line_matches = 0;
  int nline = 1;

  while (fgets(text, buff_size - 1, fp) != NULL) {
    int status = regexec(&reg, text, 1, pmatch, 0);
    int match = 0;

    if (status == 0 && !flag->v) match = 1;
    if (status == REG_NOMATCH && flag->v) match = 1;
    if (match && !flag->l && !flag->c && flag->n) printf("%d:", nline);
    if (match && !flag->l && !flag->c && !flag->o) printf("%s", text);

    if (flag->o && match) {
      for (int count = pmatch[0].rm_so; count < pmatch[0].rm_eo; count++) {
        printf("%c", text[count]);
      }
      printf("\n");
    }

    line_matches += match;
    nline++;
  }

  if (flag->l && line_matches > 0) printf("%s\n", file);
  if (flag->c && !flag->l) printf("%d\n", line_matches);
}
