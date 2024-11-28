require 'rspec'

# Лямбда для обчислення факторіала
factorial = ->(n) do
  raise ArgumentError, "Negative numbers are not allowed" if n < 0
  (1..n).inject(1, :*)
end

# Тести
RSpec.describe 'Factorial Lambda' do
  it 'returns 1 for factorial of 1' do
    expect(factorial.call(1)).to eq(1)
  end

  it 'returns 2 for factorial of 2' do
    expect(factorial.call(2)).to eq(2)
  end

  it 'returns 6 for factorial of 3' do
    expect(factorial.call(3)).to eq(6)
  end

  it 'returns 24 for factorial of 4' do
    expect(factorial.call(4)).to eq(24)
  end

  it 'returns 120 for factorial of 5' do
    expect(factorial.call(5)).to eq(120)
  end

  it 'raises an error for invalid input (negative number)' do
    expect { factorial.call(-1) }.to raise_error(ArgumentError, "Negative numbers are not allowed")
  end
end
