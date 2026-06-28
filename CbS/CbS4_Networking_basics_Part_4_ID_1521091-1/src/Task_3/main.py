from scapy.all import IP, TCP, send

# 1. Задаем текст сообщения
message = "Dear Steel Cat! This is no attack, it's my humster Pinkie you should track"

# 2. Собираем пакет-матрешку: IP-уровень / TCP-уровень / Данные
# dst="127.0.0.1" — отправка на локальный адрес
# dport=12345 — порт назначения
# flags="PA" — флаги PSH и ACK (классический набор для передачи данных в TCP)
packet = IP(dst="127.0.0.1") / TCP(dport=12345, flags="PA") / message

# 3. Отправляем пакет в сеть
print("Отправка пакета через Scapy...")
send(packet)
print("Пакет успешно отправлен!")
