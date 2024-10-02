class Handler
  attr_accessor :next_handler

  def set_next(handler)
    @next_handler = handler
    handler
  end

  def handle(request)
    if @next_handler
      @next_handler.handle(request)
    else
      nil
    end
  end
end

class ConcreteHandlerA < Handler
  def handle(request)
    if request == 'A'
      puts 'Handler A обробляє запит.'
    else
      super
    end
  end
end

class ConcreteHandlerB < Handler
  def handle(request)
    if request == 'B'
      puts 'Handler B обробляє запит.'
    else
      super
    end
  end
end

class ConcreteHandlerC < Handler
  def handle(request)
    if request == 'C'
      puts 'Handler C обробляє запит.'
    else
      super
    end
  end
end

# Створення обробників
handler_a = ConcreteHandlerA.new
handler_b = ConcreteHandlerB.new
handler_c = ConcreteHandlerC.new

# Налаштування ланцюга
handler_a.set_next(handler_b).set_next(handler_c)

# Тестування
handler_a.handle('A')  # Виведе: Handler A обробляє запит.
handler_a.handle('B')  # Виведе: Handler B обробляє запит.
handler_a.handle('C')  # Виведе: Handler C обробляє запит.
handler_a.handle('D')  # Нічого не виведе, оскільки жоден обробник не обробив запит.
