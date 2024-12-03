class Timer
  attr_reader :elapsed_time

  def initialize
    @start_time = nil
    @end_time = nil
    @elapsed_time = 0
  end

  def start
    @start_time = Time.now
  end

  def stop
    @end_time = Time.now
    @elapsed_time = @end_time - @start_time
  end

  def formatted_time
    hours, rem = @elapsed_time.divmod(3600)
    minutes, seconds = rem.divmod(60)
    format("%02d:%02d:%06.3f", hours, minutes, seconds)
  end

  def self.measure(log: false)
    timer = new
    timer.start
    yield if block_given?
    timer.stop
    puts "Час виконання: #{timer.formatted_time}" if log
    timer.elapsed_time
  end
end

# Приклад використання
time_taken = Timer.measure(log: true) do
  sleep(2.5) # Емуляція коду
end

puts "Точний час виконання: #{time_taken} секунд"
