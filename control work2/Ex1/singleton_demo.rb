class Singleton
  # Створення єдиного екземпляра
  @instance = nil

  private_class_method :new

  def self.instance
    @instance ||= new
  end

  # Приклад атрибута
  attr_accessor :data

  def initialize
    @data = "Default data"
  end
end

# Тестування
singleton1 = Singleton.instance
singleton2 = Singleton.instance

singleton1.data = "Updated data"

puts singleton2.data # Результат: "Updated data"
puts singleton1.object_id == singleton2.object_id # Результат: true
