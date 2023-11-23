
#!/bin/bash

# Перевіряємо кількість аргументів
if [ "$#" -ne 3 ]; then
  echo "Неправильна кількість аргументів. Використовуйте:

batchrename.sh <directory> <original_extension> <new_extension>

Наприклад:

batchrename.sh ./images jpg png

"
  exit 1
fi

# Отримуємо аргументи
directory=$1
original_extension=$2
new_extension=$3

# Переходимо до каталогу
cd $directory

# Перебираємо всі файли в каталозі
for file in *.$original_extension; do

  # Отримуємо нове ім'я файлу
  new_name=$(echo $file | sed "s/$original_extension/$new_extension/")

  # Перейменовуємо файл
  mv $file $new_name

  # Виводимо повідомлення
  echo "Перейменовано $file на $new_name"

done