#!/bin/bash

# Отримуємо ім'я користувача
your_name=$(whoami)

# Отримуємо поточний номер файлу
current_file_number=$(ls | grep -c $your_name)

# Якщо поточний номер файлу є 0, то це означає, що ми запускаємо скрипт вперше
if [ $current_file_number -eq 0 ]; then
  # Встановлюємо поточний номер файлу на 1
  current_file_number=1
fi

# Створюємо 25 нових файлів
for i in $(seq 1 25); do

  # Отримуємо ім'я нового файлу
  new_file_name=$your_name$current_file_number

  # Створюємо новий файл
  touch $new_file_name

  # Збільшуємо поточний номер файлу
  current_file_number=$((current_file_number + 1))

done