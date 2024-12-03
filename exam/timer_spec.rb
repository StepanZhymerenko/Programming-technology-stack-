require_relative 'timer'

RSpec.describe Timer do
  describe '#start' do
    it 'записує початковий час' do
      timer = Timer.new
      timer.start
      expect(timer.instance_variable_get(:@start_time)).not_to be_nil
    end
  end

  describe '#stop' do
    it 'записує кінцевий час і обчислює час виконання' do
      timer = Timer.new
      timer.start
      sleep(0.1) # Емуляція затримки
      timer.stop
      expect(timer.instance_variable_get(:@end_time)).not_to be_nil
      expect(timer.elapsed_time).to be > 0
    end
  end

  describe '#formatted_time' do
    it 'повертає час у форматі годин, хвилин та секунд' do
      timer = Timer.new
      timer.start
      sleep(0.1) # Емуляція затримки
      timer.stop
      formatted = timer.formatted_time
      expect(formatted).to match(/\A\d{2}:\d{2}:\d{2}\.\d{3}\z/)
    end
  end

  describe '.measure' do
    it 'вимірює час виконання блоку' do
      elapsed_time = Timer.measure do
        sleep(0.2) # Емуляція роботи
      end
      expect(elapsed_time).to be >= 0.2
    end

    it 'працює без блоку і не викликає помилок' do
      expect { Timer.measure }.not_to raise_error
    end

    it 'логує час виконання, якщо опція log: true' do
      expect { Timer.measure(log: true) { sleep(0.1) } }.to output(/Час виконання:/).to_stdout
    end
  end
end
