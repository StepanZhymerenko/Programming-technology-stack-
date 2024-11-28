factorial = ->(n) do
  raise ArgumentError, "Negative numbers are not allowed" if n < 0
  n == 0 ? 1 : (1..n).inject(1, :*)
end

# Використання лямбди для чисел від 1 до 5
(1..5).each do |i|
  puts "Факторіал #{i} дорівнює #{factorial.call(i)}"
end
