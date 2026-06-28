#!/bin/bash

scp /home/ondrewsa/builds/JKA2iK4ys/0/students_repo/ondrewsa/DO6_CICD.ID_356283-1/src/SimpleBash/cat/s21_cat ondrewsa@192.168.1.8:/usr/local/bin
scp /home/ondrewsa/builds/JKA2iK4ys/0/students_repo/ondrewsa/DO6_CICD.ID_356283-1/src/SimpleBash/grep/s21_grep ondrewsa@192.168.1.8:/usr/local/bin

ssh ondrewsa@192.168.1.8 ls -lah /usr/local/bin # просмотр папки на целевой машине
#
