require 'minitest/autorun'

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

class TestPerson < Minitest::Test
  def test_increase_age
    person = Person.new("Степан", 19)
    person.increase_age
    assert_equal 20, person.age
  end
end
