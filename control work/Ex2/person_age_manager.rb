class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def increase_age
    @age += 1
  end
end

# Введення даних користувачем
puts "Введіть ім'я:"
name = gets.chomp

puts "Введіть вік:"
age = gets.to_i

# Створюється нова людина з введеними даними
person = Person.new(name, age)

# Виводиться поточне ім'я та вік
puts "Ім'я: #{person.name}, Вік: #{person.age}"

# Збільшується вік на 1 рік
person.increase_age

# Виводиться ім'я та вік після збільшення
puts "Ім'я: #{person.name}, Вік: #{person.age} після дня народження"
