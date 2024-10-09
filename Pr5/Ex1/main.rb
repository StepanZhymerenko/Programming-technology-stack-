def valid_ipv4?(ip)
  octets = ip.split('.')

  return false unless octets.size == 4

  octets.all? do |octet|
    octet.match?(/^\d+$/) && octet.to_i.between?(0, 255) && octet == octet.to_i.to_s
  end
end

puts "Введіть IP-адресу для перевірки:"
ip_address = gets.chomp

if valid_ipv4?(ip_address)
  puts "#{ip_address} є валідною IPv4-адресою."
else
  puts "#{ip_address} не є валідною IPv4-адресою."
end

# Тести
puts "Перевірка інших IP-адрес:"
puts "192.168.1.1 -> #{valid_ipv4?("192.168.1.1")}"   # true
puts "256.168.1.1 -> #{valid_ipv4?("256.168.1.1")}"   # false
puts "192.168.01.1 -> #{valid_ipv4?("192.168.01.1")}" # false
puts "192.168.1 -> #{valid_ipv4?("192.168.1")}"       # false
