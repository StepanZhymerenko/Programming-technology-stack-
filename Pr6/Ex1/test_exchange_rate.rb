require 'minitest/autorun'
require 'net/http'
require 'json'
require 'csv'
require_relative 'exchange_rate'  # Підключаємо основний файл

class TestExchangeRateAPI < Minitest::Test
  # Тест на перевірку успішного отримання курсів валют
  def test_fetch_exchange_rates
    base_currency = 'USD'
    data = fetch_exchange_rates(base_currency)

    assert_equal 'success', data['result'], 'API не повертає успішний результат'
    assert data['conversion_rates'].is_a?(Hash), 'Курси валют не є хешем'
  end

  # Тест на перевірку збереження даних у CSV файл
  def test_save_to_csv
    base_currency = 'USD'
    data = {
      'conversion_rates' => {
        'EUR' => 0.85,
        'GBP' => 0.75
      }
    }

    # Використовуємо тестовий файл для збереження результатів
    test_file_name = "test_exchange_rates_#{base_currency}.csv"
    save_to_csv(data, base_currency, test_file_name)

    assert File.exist?(test_file_name), 'CSV файл не створений'

    csv_content = CSV.read(test_file_name, headers: true)
    assert_equal ['Currency', 'Rate'], csv_content.headers, 'Неправильні заголовки CSV'
    assert_equal 'EUR', csv_content[0]['Currency'], 'Неправильна валюта в CSV'
    assert_equal '0.85', csv_content[0]['Rate'], 'Неправильний курс у CSV'

    # Видаляємо тестовий файл після завершення тесту
    #File.delete(test_file_name) if File.exist?(test_file_name)
  end
end
