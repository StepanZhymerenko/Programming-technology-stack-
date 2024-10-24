require 'minitest/autorun'

# Метод для перевірки, чи є рік високосним
def leap_year?(year)
  if year % 400 == 0
    true
  elsif year % 100 == 0
    false
  elsif year % 4 == 0
    true
  else
    false
  end
end

# Клас для тестування методу leap_year?
class TestLeapYear < Minitest::Test
  # Тест для року, що ділиться на 400
  def test_divisible_by_400
    assert leap_year?(2000)  # Високосний рік
  end

  # Тест для року, що ділиться на 100, але не на 400
  def test_divisible_by_100_but_not_400
    refute leap_year?(1900)  # Не високосний рік
  end

  # Тест для року, що ділиться на 4, але не на 100
  def test_divisible_by_4_but_not_100
    assert leap_year?(2024)  # Високосний рік
  end

  # Тест для року, що не ділиться на 4
  def test_not_divisible_by_4
    refute leap_year?(2023)  # Не високосний рік
  end
end
