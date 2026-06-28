#!/bin/bash

if [ $# -ne 4 ]; then
    echo "ОШИБКА: Нужно задать четыре цвета"
    echo "1й - фон названий значений"
    echo "2й - цвет шрифта названий значений"
    echo "3й - фон значений после знака равенства"
    echo "4й - цвет шрифта значений после знака равенства"
    echo "1 - белый, 2 - красный, 3 - зеленый, 4 - синий, 5 - фиолетовый, 6 - черный"
    exit 1
fi

for i in {1..4}; do
    if ! [[ ${!i} =~ ^[1-6]$ ]]; then
        echo "ОШИБКА: Параметры цвета должны быть от 1 до 6"
        exit 1
    fi
done

if [ "${1}" = "${2}" ] || [ "${3}" = "${4}" ]; then
    echo "ОШИБКА: Цвета шрифта и фона должны отличаться."
    read -p "Перезапустить скрипт? (Y/N) " choice
    if [[ ${choice} =~ ^[Yy]$ ]]; then
        read -p "bash main.sh " arg
        bash main.sh $arg
        exit 0
    else
        exit 1
    fi
fi

bg_color=('47' '41' '42' '44' '45' '40')
font_color=('97' '91' '92' '94' '95' '90')

bg_val_names=${bg_color[$1 - 1]}
font_val_names=${font_color[$2 - 1]}
bg_vals=${bg_color[$3 - 1]}
font_vals=${font_color[$4 - 1]}

function  cur_timezone() {
  #local timezone=$(timedatectl show --property=Timezone --value)
  local timezone=$(timedatectl show -p Timezone --value)  # показать свойство Timezone, только его величину
#  local offset=$(date +"%-:z" | sed 's/:[0-9]*$//')
  local offset=$(date +"%-:z" | sed 's/:.*$//') #получить время смещения без ведущего нуля и удалить все символы после двоеточия вместе с ним
  echo "${timezone} UTC ${offset}"
}


HOSTNAME=$(hostname)
USER=$(whoami)
TIMEZONE=$(cur_timezone)
OS=$(source /etc/os-release && printf "%s" "$PRETTY_NAME")
DATE=$(date +"%d %B %Y %H:%M:%S")
UPTIME=$(uptime -p | sed 's/^up //')
UPTIME_SEC=$(cat /proc/uptime | awk '{print int($1)}')
IP=$(ip addr show | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d/ -f1)
MASK=$(ifconfig | grep -w 'inet' | awk '{print $4}' | head -n 1)
GATEWAY=$(ip route | grep default | awk '{print $3}')

RAM_TOTAL=$(free -m | awk '/Mem:/ {printf "%.3f GB\n", $2/1024}')
RAM_USED=$(free -m | awk '/Mem:/ {printf "%.3f GB\n", $3/1024}')
RAM_FREE=$(free -m | awk '/Mem:/ {printf "%.3f GB\n", $4/1024}')
SPACE_ROOT=$(df -k / | awk '/\// {printf "%.2f MB\n", $2/(1024)}')
SPACE_ROOT_USED=$(df -k / | awk '/\// {printf "%.2f MB\n", $3/(1024)}')
SPACE_ROOT_FREE=$(df -k / | awk '/\// {printf "%.2f MB\n", $4/(1024)}')


  VARIABLES=(HOSTNAME TIMEZONE USER OS DATE UPTIME UPTIME_SEC IP MASK GATEWAY RAM_TOTAL RAM_USED RAM_FREE SPACE_ROOT SPACE_ROOT_USED SPACE_ROOT_FREE)
          VALUES=("$HOSTNAME" "$TIMEZONE" "$USER" "$OS" "$DATE" "$UPTIME" "$UPTIME_SEC" "$IP" "$MASK" "$GATEWAY" "$RAM_TOTAL" "$RAM_USED" "$RAM_FREE" "$SPACE_ROOT" "$SPACE_ROOT_USED" "$SPACE_ROOT_FREE")

          for ((i=0; i < ${#VARIABLES[@]}; i++)); do
            printf "\e[${bg_val_names};${font_val_names}m%s\e[0m" "${VARIABLES[i]}"
            printf " = "
            printf "\e[${bg_vals};${font_vals}m%s\e[0m\n" "${VALUES[i]}"
          done
