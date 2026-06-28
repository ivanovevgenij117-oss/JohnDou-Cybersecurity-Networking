#задаем базовый образ контейнера
FROM nginx:latest

#устанавливаем обновления, нужные программы и чистим кэш apt
RUN apt update -y && apt upgrade -y \
&& apt-get install -y gcc -y spawn-fcgi -y libfcgi-dev \
&& rm -rf /var/lib/apt/lists

#копируем исходник cgi сервера
COPY hello.c .
#копируем конфигурацию nginx
COPY default.conf ../etc/nginx/conf.d/default.conf
#копируем скрипт
COPY script.sh /

#и запускаем его
ENTRYPOINT ["bash", "script.sh"]
