#include <stdio.h>
#include <string.h>

int main(){

    char word[255] = "Привет, мир!";
    char code[255] = "Pass";
    char newword[255];
    char restore_word[255];

    printf("%s\n", word);
  

    int code_len = strlen(code);
    int i = 0;

    while(word[i] != '\0'){
        newword[i] = word[i] ^ code[i%code_len];
        i++;
    }
    newword[i] = '\0';
    i = 0;

    printf("%s\n", newword);


    while(newword[i] != '\0'){
        restore_word[i] = newword[i] ^ code[i%code_len];
        i++;
    }
    restore_word[i] = '\0';

    printf("%s\n", restore_word);

    return 0;
}