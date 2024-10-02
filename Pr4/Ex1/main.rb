def find_raisins(cake)
  raisins = []
  cake.each_with_index do |row, i|
    row.chars.each_with_index do |char, j|
      raisins << [i, j] if char == 'o'
    end
  end
  raisins
end

def cut_cake(cake, raisins)
  # Спочатку спробую горизонтальні розрізи
  horizontal_cuts = find_horizontal_cuts(cake, raisins)
  vertical_cuts = find_vertical_cuts(cake, raisins)

  # Вибираю рішення з найбільшою шириною першого шматка
  [horizontal_cuts, vertical_cuts].max_by { |solution| solution.first.first.length }
end

def find_horizontal_cuts(cake, raisins)
  cuts = []
  prev_row = 0
  raisins.each_with_index do |(i, _), idx|
    next_row = (idx == raisins.size - 1) ? cake.size - 1 : raisins[idx + 1][0] - 1
    cuts << cake[prev_row..next_row]
    prev_row = next_row + 1
  end
  cuts
end

def find_vertical_cuts(cake, raisins)
  transposed_cake = cake.map(&:chars).transpose.map(&:join)
  horizontal_solution = find_horizontal_cuts(transposed_cake, raisins.map { |i, j| [j, i] })
  horizontal_solution.map { |cut| cut.map(&:chars).transpose.map(&:join) }
end

# Основна функція
def cut_cake_with_raisins(cake)
  cake_lines = cake.split("\n").map(&:strip)
  raisins = find_raisins(cake_lines)
  cut_cake(cake_lines, raisins)
end

# Тестовий приклад
cake = <<~CAKE
  .o......
  ......o.
  ....o...
  ..o.....
CAKE

result = cut_cake_with_raisins(cake)
puts "Результат розрізання:"
result.each_with_index do |piece, i|
  puts "Кусок #{i + 1}:"
  puts piece.join("\n")
  puts
end
