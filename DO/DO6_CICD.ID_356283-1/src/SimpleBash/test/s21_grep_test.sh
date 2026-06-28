#!/bin/bash

echo "Hi!"

arg_1="one ../test/pattern.txt"
arg_2="../test/pattern.txt ../test/tst.txt"
arg_3="one ../test/pattern.txt ../test/tst.txt"
arg_4="one ../test/patttern.txt"
arg_5="One ../test/pattern.txt"

for flag in -c -f -h -l -n -o -s -v -i
do
    > 1.txt
    > 2.txt
    arg=$arg_1

    if [ "$flag" = "-f" ]; then
        arg=$arg_2
    fi

    if ( [ "$flag" = "-h" ] || [ "$flag" = "-l" ] ); then
        arg=$arg_3
    fi

    if [ "$flag" = "-s" ]; then
        arg=$arg_4
    fi

    if [ "$flag" = "-i" ]; then
        arg=$arg_5
    fi
    ../grep/s21_grep $flag $arg > 1.txt
    grep $flag $arg > 2.txt
    diff 1.txt 2.txt

    if [ $? -eq 0 ]; then
        echo "Test '$flag' completed successfully"
        else echo "Test '$flag' fault"
    fi
    rm 1.txt 2.txt

done
