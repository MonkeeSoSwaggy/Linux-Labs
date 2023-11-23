#!/bin/bash

# Функція для додавання запису до адресної книги
function add_record() {
  # Отримуємо ім'я та електронну адресу
  name=$1
  email=$2

  # Перевіряємо, чи існує запис з таким іменем
  if grep -q "^$name$" $address_book_file; then
    echo "Запис з таким іменем вже існує"
    return
  fi

  # Додаємо запис до файлу
  echo "$name|$email" >> $address_book_file
}

# Функція для відображення всіх записів в адресній книзі
function list_records() {
  # Якщо файл адресної книги відсутній, виводимо повідомлення
  if [ ! -f $address_book_file ]; then
    echo "Адресна книга порожня"
    return
  fi

  # Відкриваємо файл для читання
  address_book=$(cat $address_book_file)

  # Перебираємо всі записи в файлі
  for record in $address_book; do
    # Розбиваємо запис на ім'я та електронну адресу
    name=$(echo $record | cut -d '|' -f1)
    email=$(echo $record | cut -d '|' -f2)

    # Виводимо запис
    echo "$name: $email"
  done
}

# Функція для видалення записів з адресної книги
function remove_record() {
  # Отримуємо ім'я
  name=$1

  # Відкриваємо файл для читання
  address_book=$(cat $address_book_file)

  # Створюємо новий файл для запису
  new_address_book=$(mktemp)

  # Перебираємо всі записи в файлі
  for record in $address_book; do
    # Якщо ім'я не збігається, додаємо запис до нового файлу
    if [ "$name" != $(echo $record | cut -d '|' -f1) ]; then
      echo $record >> $new_address_book
    fi
  done

  # Перезаписуємо файл адресної книги новим вмістом
  mv $new_address_book $address_book_file
}

# Функція для очищення адресної книги
function clear_records() {
  # Видаляємо файл адресної книги
  rm -f $address_book_file
}

# Функція для пошуку електронних адрес
function lookup_records() {
  # Отримуємо ім'я
  name=$1

  # Відкриваємо файл для читання
  address_book=$(cat $address_book_file)

  # Перебираємо всі записи в файлі
  for record in $address_book; do
    # Якщо ім'я збігається, додаємо запис до нового файлу
    if [ "$name" = $(echo $record | cut -d '|' -f1) ]; then
      # Виводимо запис
      echo "$record"
    fi
  done
}

# Основна частина скрипта

# Ім'я файлу адресної книги
address_book_file="./address_book.txt"

# Опрацьовуємо аргументи командного рядка
case $1 in
  new)
    # Додаємо запис
    add_record $2 $3
    ;;
  list)
    # Відображаємо всі записи
    list_records
    ;;
  remove)
    # Видаляємо записи
    remove_record $2
    ;;
  clear)
    # Очищаємо адресну книгу
    clear_records
    ;;
  lookup)
    # Шукаємо електронні адреси
    lookup_records $2
    ;;
  *)
    echo "Неправильний аргумент"
    ;;
esac