#!/bin/bash

#проверка на запуск от root
if [ "$EUID" -ne 0 ]; then
	echo "скрипт нужно запускать с правами root"
	exit 1
fi

echo "===Сбор системной информации==="

#echo "Установка утилит cowsay и sl..."
#apt update -y --allow-unauthenticated #игнорируем проблемы с безопасностью
#apt install cowsay sl -y

#инициируем чистый файл для записи резултатов
OUTPUT_FILE="info"
echo -e "\n[1/4] Сбор информации о ядре и ОС..."
echo "ОТЧЕТ О СОСТОЯНИИ СИСТЕМЫ">$OUTPUT_FILE 	#перезаписываем файл
echo "==================">>$OUTPUT_FILE		#дописываем в конец файла

#собираем версию ядра и ОС
echo -e "\n---ВЕРСИЯ ОС И ЯДРА---">>$OUTPUT_FILE
uname -a >>$OUTPUT_FILE

#сбор списка установленных пакетов
echo -e "\n[2/4] Сбор установленных пакетов..."
echo -e "\n---УСТАНОВЛЕННЫЕ ПАКЕТЫ---">>$OUTPUT_FILE
dpkg -l >>$OUTPUT_FILE

#чтение запущенных процессов
echo -e "\n[3/4] Сбор запущенных процессов..."
echo -e "\n---ЗАПУЩЕННЫЕ ПРОЦЕССЫ---">>$OUTPUT_FILE
ps aux >>$OUTPUT_FILE

#чтение открытых портов
echo -e "\n[4/4] Сбор запущенных портов и сетевых соединений..."
echo -e "\n---ОТКРЫТЫЕ СЕТЕВЫЕ ПОРТЫ---">>$OUTPUT_FILE
ss -tuln >>$OUTPUT_FILE

echo "===сбор данных завершен. файл info создан==="

#архивация данных
echo "Архивируем данные в OS_RESULT.tar"
tar -cvf OS_RESULT.tar $OUTPUT_FILE

#удаляем промежуточный файл
rm $OUTPUT_FILE
echo "===Архив создан==="