def to_rpn(expression)
  output = []
  stack = []
  precedence = { "+" => 1, "-" => 1, "*" => 2, "/" => 2, "(" => 0 }

  tokens = expression.split

  tokens.each do |token|
    if token =~ /\d+/ # якщо це число
      output << token
    elsif ["+", "-", "*", "/"].include?(token) # якщо це оператор
      while stack.any? && precedence[stack.last] >= precedence[token]
        output << stack.pop
      end
      stack << token
    elsif token == "(" # якщо це відкрита дужка
      stack << token
    elsif token == ")" # якщо це закрита дужка
      while stack.any? && stack.last != "("
        output << stack.pop
      end
      stack.pop # видаляємо відкриту дужку з стека
    end
  end

  output.concat(stack.reverse) # додаємо всі залишки зі стека
  output.join(" ")
end

# Приклад використання
puts to_rpn("2 + ( 1 * 4 )") # має вивести: 2 1 4 * +
puts to_rpn("3 + ( 2 - 1 ) * 5") # має вивести: 3 2 1 - 5 * +
