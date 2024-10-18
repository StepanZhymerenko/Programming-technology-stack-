require 'net/http'
require 'json'
require 'csv'

API_KEY = '44fd163e868685399a44a7fe'  # Замініть на свій реальний API-ключ
BASE_URL = 'https://v6.exchangerate-api.com/v6/'

# Отримання курсів валют для вибраної базової валюти
def fetch_exchange_rates(base_currency)
  url = URI("#{BASE_URL}#{API_KEY}/latest/#{base_currency}")
  response = Net::HTTP.get(url)
  JSON.parse(response)
end

# Збереження даних у CSV файл
def save_to_csv(data, base_currency, file_name = "exchange_rates_#{base_currency}.csv")
  CSV.open(file_name, 'wb', write_headers: true, headers: ['Currency', 'Rate']) do |csv|
    data['conversion_rates'].each do |currency, rate|
      csv << [currency, rate]
    end
  end
end

# Основна логіка
if __FILE__ == $PROGRAM_NAME
  base_currency = 'USD'  # Можна замінити на будь-яку іншу валюту, наприклад EUR
  exchange_data = fetch_exchange_rates(base_currency)

  if exchange_data['result'] == 'success'
    save_to_csv(exchange_data, base_currency)
    puts "Дані успішно збережені в exchange_rates_#{base_currency}.csv"
  else
    puts "Не вдалося отримати дані. Статус: #{exchange_data['result']}"
  end
end
