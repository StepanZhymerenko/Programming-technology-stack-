# В цій програмі аргумент комп'ютера обирається рандомно
puts "Передані аргументи: #{ARGV}"

# Отримуємо вибір гравця через перший аргумент
player_choice = ARGV[0]

# Варіанти комп'ютера
choices = ["камінь", "ножиці", "папір"]

# Перевіряємо, чи гравець передав правильний варіант
if !choices.include?(player_choice)
  puts "Неправильний варіант. Виберіть: камінь, ножиці або папір."
  exit
end

# Вибір комп'ютера
computer_choice = choices.sample

puts "Комп'ютер обрав: #{computer_choice}"

# Визначення результату
if player_choice == computer_choice
  puts "Нічия!"
elsif (player_choice == "камінь" && computer_choice == "ножиці") ||
  (player_choice == "ножиці" && computer_choice == "папір") ||
  (player_choice == "папір" && computer_choice == "камінь")
  puts "Ви виграли!"
else
  puts "Комп'ютер виграв!"
end
