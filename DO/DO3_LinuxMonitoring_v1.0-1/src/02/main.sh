#!/bin/bash

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

echo "HOSTNAME = $HOSTNAME"
echo "TIMEZONE = $TIMEZONE"
echo "USER = $USER"
echo "OS = $OS"
echo "DATE = $DATE"
echo "UPTIME = $UPTIME"
echo "UPTIME_SEC = $UPTIME_SEC"
echo "IP = $IP"
echo "MASK = $MASK"
echo "GATEWAY = $GATEWAY"
echo "RAM_TOTAL = $RAM_TOTAL"
echo "RAM_USED = $RAM_USED"
echo "RAM_FREE = $RAM_FREE"
echo "SPACE_ROOT = $SPACE_ROOT"
echo "SPACE_ROOT_USED = $SPACE_ROOT_USED"
echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE"

# Запрашиваем подтверждение у пользователя
read -p "Save this information to a file? (Y/N): " choice

case "$choice" in
    Y|y ) # Пользователь подтвердил сохранение
          echo "Saving data..."
          TIMESTAMP=$(date +"%d_%m_%y_%H_%M_%S")
          FILENAME="${TIMESTAMP}.status"

          VARIABLES=(HOSTNAME TIMEZONE USER OS DATE UPTIME UPTIME_SEC IP MASK GATEWAY RAM_TOTAL RAM_USED RAM_FREE SPACE_ROOT SPACE_ROOT_USED SPACE_ROOT_FREE)
          VALUES=("$HOSTNAME" "$TIMEZONE" "$USER" "$OS" "$DATE" "$UPTIME" "$UPTIME_SEC" "$IP" "$MASK" "$GATEWAY" "$RAM_TOTAL" "$RAM_USED" "$RAM_FREE" "$SPACE_ROOT" "$SPACE_ROOT_USED" "$SPACE_ROOT_FREE")

          for ((i=0; i < ${#VARIABLES[@]}; i++)); do
            echo "${VARIABLES[i]} = ${VALUES[i]}" >> $FILENAME
          done

          echo "Data has been successfully saved."
          ;;
    N|n ) # Пользователь отказался сохранять
          echo "Operation cancelled by user."
          exit 0
          ;;
    *)     # Некорректный выбор
          echo "Invalid input. Please enter Y or N."
          exit 1
esac