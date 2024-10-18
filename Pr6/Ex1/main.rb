require 'net/http'
require 'json'
require 'csv'

class CurrencyRatesFetcher
  API_URL = 'https://v6.exchangerate-api.com/v6/YOUR_API_KEY/latest/'.freeze

  def initialize(base_currency)
    @base_currency = base_currency
  end

  def fetch_exchange_rates
    uri = URI("#{API_URL}#{@base_currency}")
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    if data['result'] == 'success'
      data['conversion_rates']
    else
      raise "API error: #{data['error-type']}"
    end
  end

  def save_to_csv(rates, file_name = 'currency_rates.csv')
    CSV.open(file_name, 'w') do |csv|
      csv << ['Currency', 'Rate']
      rates.each do |currency, rate|
        csv << [currency, rate]
      end
    end
  end
end

# Використання:
fetcher = CurrencyRatesFetcher.new('USD')
rates = fetcher.fetch_exchange_rates
fetcher.save_to_csv(rates)
