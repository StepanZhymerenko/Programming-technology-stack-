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

puts "Введіть рік:"
year = gets.to_i

if leap_year?(year)
  puts "#{year} рік є високосним."
else
  puts "#{year} рік не є високосним."
end
