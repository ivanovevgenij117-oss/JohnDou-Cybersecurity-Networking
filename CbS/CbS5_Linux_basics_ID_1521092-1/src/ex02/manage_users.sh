#!/bin/bash

#проверка на запуск от root
if [ "$EUID" -ne 0 ]; then
	echo "скрипт нужно запускать с правами root"
	exit 1
fi

echo "===Старт настройки пользователей и прав==="

echo "создаем группу defaut_users и пользователя user..."
getent group default_users &>/dev/null || groupadd -f default_users
#если группа существует то правая часть игнорируется
# &>/dev/null подавляет вывод команды на экран. сообщение типа "пользователь уже существует"

id -u user &>/dev/null || useradd -m -g default_users user
# -m создаем домашнюю директорию -g и задаем основную группу
#пользователь уже существует то правая часть игнорируется

echo "создаем группу secret_users и секретных пользователей..."
getent group secret_users &>/dev/null || groupadd -f secret_users
for username in secret_agent secret_spy secret_boss; do
	id -u $username &>/dev/null || useradd -m -g secret_users $username
done

# По умолчанию в Linux домашние папки имеют права 750 или 700 (чужие не войдут).
# Нам нужно сделать так, чтобы группа (secret_users) могла читать и заходить (r-x).
echo "Настройка прав для домашних директорий secret_users..."
for username in secret_agent  secret_spy secret_boss; do
	chown $username:secret_users /home/$username
	chmod 750 /home/$username
done

echo "открываем общий доступ к var..."
chmod 777 /var

echo "устанавливаем веб-сервис apache..."
apt update -y --allow-unauthenticated
apt install apache2 -y

echo "проверка состояния сервиса apache2..."
systemctl status apache2 --no-pager | head -n 15

#Настройка sudo без пароля для группы default_users
# напрямую /etc/sudoers не меняем, чтобы не поломать настройки
# поэтому делаем дополнительный файл настроек в /etc/sudoers.d/
echo "Настройка sudoers для группы default_users..."
SUDOERS_FILE="/etc/sudoers.d/default_users_rules"

#даем прова выполнять sudo без пароля всем пользователям из default_users
echo "%default_users ALL=(ALL:ALL) NOPASSWD: ALL">$SUDOERS_FILE
#даем права в нашему файлу в sudoers.d 0440(только чтение) иначе он не сработает
chmod 0440 $SUDOERS_FILE

echo "===Все задачи успешно выполнены==="