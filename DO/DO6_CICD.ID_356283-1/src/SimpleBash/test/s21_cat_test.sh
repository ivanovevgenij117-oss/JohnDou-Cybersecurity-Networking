#!/bin/bash

echo "Hi!"

fileName1="../test/tstr.txt"
fileName2="../test/tst.txt"
fileName3="../test/ttt.txt"


for flag in -e -E -b --number-nonblank --number -n -s --squeeze-blank -t -T -v
do
    > 1.txt
    > 2.txt
    fileName=$fileName2

    if ( [ "$flag" = "-e" ] || [ "$flag" = "-E" ]); then
        fileName=$fileName1
    fi
    if ( [ "$flag" = "-T" ] || [ "$flag" = "-v" ]); then
        fileName=$fileName3
    fi

    ../cat/s21_cat $flag $fileName > 1.txt
    cat $flag $fileName > 2.txt
    diff 1.txt 2.txt

    if [ $? -eq 0 ]; then
        echo "Test '$flag' completed successfully"
        else echo "Test '$flag' fault"
    fi
    rm 1.txt 2.txt
done
