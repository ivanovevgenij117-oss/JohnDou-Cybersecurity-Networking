#!/usr/bin/env python3
import hashlib
import os

def crack_hash_from_file(target_hash, dictionary_path):
    if not os.path.exists(dictionary_path):
        print(f"[-] Файл словаря '{dictionary_path}' не найден!")
        return None
        
    print(f"[*] Сканирую словарь {dictionary_path}...")
    with open(dictionary_path, 'r', encoding='utf-8', errors='ignore') as f:
        for count, line in enumerate(f, 1):
            password = line.strip()
            guess_hash = hashlib.sha512(password.encode('utf-8')).hexdigest()
            if guess_hash == target_hash:
                return password
    return None

if __name__ == "__main__":
    target = "e239f67756bba3af660e4226c340183a9ca4bdc40038c0cfdea2fbaa59605be32548df2535e5a9f9ceedb12d9666c6fb153ada99830ed5cd84eb0c2c4d00260a"
    dict_file = "rockyou.txt"
    
    result = crack_hash_from_file(target, dict_file)
    if result:
        print(f"[+] ПАРОЛЬ ВЗЛОМАН: {result}")
    else:
        print("[-] Пароль не найден в файле.")
