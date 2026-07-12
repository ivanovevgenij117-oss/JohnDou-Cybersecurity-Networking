#!/usr/bin/env python3
import sys

def xor_strings(str1, str2):
    # Превращаем строки в сырые байты (UTF-8/ASCII совместимые)
    bytes1 = str1.encode('utf-8')
    bytes2 = str2.encode('utf-8')
    
    # Защита от выхода за границы: берем минимальную длину из двух строк
    min_len = min(len(bytes1), len(bytes2))
    
    # Побитово применяем оператор XOR (^) к каждому байту на лету
    result = bytearray()
    for i in range(min_len):
        result.append(bytes1[i] ^ bytes2[i])
        
    return result

if __name__ == "__main__":
    # Исходные строки для теста
    string_a = "Привет, мир!"
    string_b = "Привет, мир!"
    
    # Запуск расчета
    output_bytes = xor_strings(string_a, string_b)
    
    # Вывод результатов в консоль
    print(f"Строка 1 : {string_a}")
    print(f"Строка 2 : {string_b}")
    print(f"Результат (сырые байты): {bytes(output_bytes)}")
    print(f"Результат (в HEX виде) : {output_bytes.hex()}")
