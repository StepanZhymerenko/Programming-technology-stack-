# frozen_string_literal: true

# В цій програмі аргументи обох гравців передаються через командний рядок
puts "Передані аргументи гравця1: #{ARGV[0]}"
puts "Передані аргументи гравця2: #{ARGV[1]}"

# Отримуємо вибір гравців через перший і другий аргументи
player1_choice = ARGV[0]
player2_choice = ARGV[1]

# Варіанти
choices = ["камінь", "ножиці", "папір"]

# Перевіряємо, чи обидва гравці передали правильні варіанти
unless choices.include?(player1_choice) && choices.include?(player2_choice)
  puts "Неправильний варіант. Виберіть: камінь, ножиці або папір."
  exit
end

# Виведення вибору гравців
puts "Гравець1 обрав: #{player1_choice}"
puts "Гравець2 обрав: #{player2_choice}"

# Визначення результату
if player1_choice == player2_choice
  puts "Нічия!"
elsif (player1_choice == "камінь" && player2_choice == "ножиці") ||
  (player1_choice == "ножиці" && player2_choice == "папір") ||
  (player1_choice == "папір" && player2_choice == "камінь")
  puts "Гравець1 виграв!"
else
  puts "Гравець2 виграв!"
end
