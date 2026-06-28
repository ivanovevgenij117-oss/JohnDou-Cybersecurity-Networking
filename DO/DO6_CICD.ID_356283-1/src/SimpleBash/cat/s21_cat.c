#include "s21_cat.h"

int main(int argc, char *argv[]) {
  int Field_b = 0, Field_e = 0, Field_n = 0, Field_s = 0, Field_t = 0,
      Field_v = 0;

  if (argc > 1 &&
      ListOfFields(argc, argv, &Field_b, &Field_e, &Field_n, &Field_s, &Field_t,
                   &Field_v)) {  // если аргументы есть
    // argc - это количество групп аргументов

    if (optind < argc) {  // перебираем аргументы идущие после второй группы -
                          // имена файлов
      int ch;
      int EmptyString = 1;
      int NumberOfString = 1, LastSymbol = 0;
      int Enter = 1, PrevEnter = 1;
      int NoPrint = 0;

      while (optind < argc) {
        FILE *file = fopen(argv[optind++], "r");  // открываем файл
        if (file != NULL) {
          // выводим файл:

          while ((ch = getc(file)) != EOF) {
            if (ch == '\n' && Field_e == 1) printf("$");  // Field_e

            if (Field_n == 1) {  // Field_n
              if (NumberOfString == 1 || LastSymbol == 1) {
                printf("%6d\t", NumberOfString);
                NumberOfString++;
                LastSymbol = 0;
              }
              if (ch == '\n') LastSymbol = 1;
            }

            if (ch == '\n' && Field_s == 1) EmptyString++;  // Field_s
            if (ch != '\n' && Field_s == 1 && EmptyString > 0)
              EmptyString = 0;  // Field_s

            if (Field_b == 1) {  // Field_b
              if (PrevEnter == 1 && ch != '\n') {
                printf("%6d\t", Enter);
                PrevEnter = 0;
                Enter++;
              }
              if (ch == '\n') PrevEnter = 1;
            }

            if (Field_t == 1) {  // Field_t
              if (ch == '\t') {
                printf("^I");
                NoPrint = 1;
              } else
                NoPrint = 0;
            }

            if (Field_v == 1 && ch != '\t' && ch != '\n') {  // Field_v
              if (ch >= 128) {
                ch -= 128;
                printf("M-");
              }

              if (ch < 32 || ch == 127) {
                ch ^= 0x40;
                printf("^");
              }
            }

            if (EmptyString <= 2 && NoPrint == 0)
              putchar(ch);  // Вывод символа. Первое условие - подавление
                            // повторяющихся переводов строки
          }
          fclose(file);  // закрываем файл
        }
      }
    } else
      printf("no files\n");  // если после второй группы аргументов нет, т.е нет
                             // файлов

  } else
    printf("Invalid options\n");  // если аргументы не распознаны
}

int ListOfFields(int argc, char *argv[], int *Field_b, int *Field_e,
                 int *Field_n, int *Field_s, int *Field_t, int *Field_v) {
  int value = 0, rez = 1;
  struct option LongOptions[] = {{"number-nonblank", 0, 0, 'b'},
                                 {"number", 0, 0, 'n'},
                                 {"squeeze-blank", 0, 0, 's'},
                                 {NULL, 0, NULL, 0}};

  while ((value = getopt_long(argc, argv, "vbenstTE", LongOptions, NULL)) !=
         -1) {
    switch (value) {
      case 'v':
        *Field_v = 1;  // отображение нечитаемых символов
        break;
      case 'b':
        *Field_b = 1;  // нумеруем непустые строки
        break;
      case 'e':
        *Field_e = 1;  // показываем $ в конце строки
        *Field_v = 1;  // показываем непечатные символы
        break;
      case 'n':
        *Field_n = 1;  // нумеруем все строки
        break;
      case 's':  // подавление повторяющихся переводов строки
        *Field_s = 1;
        break;
      case 't':
        *Field_t = 1;  // отображение табулатур как ^I
        *Field_v = 1;
        break;
      case 'T':
        *Field_t = 1;
        break;
      case 'E':
        *Field_e = 1;
        break;

      default:
        rez = 0;
    }
    if (*Field_n && *Field_b) *Field_n = 0;
  }
  return rez;
}
