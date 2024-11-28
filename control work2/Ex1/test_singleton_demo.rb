require 'rspec'

class Singleton
  @instance = nil

  private_class_method :new

  def self.instance
    @instance ||= new
  end

  attr_accessor :data

  def initialize
    @data = "Default data"
  end

  # Скидання стану для тестів
  def self.reset_instance
    @instance = nil
  end
end

# Тести
RSpec.describe Singleton do
  before(:each) do
    Singleton.reset_instance
  end

  it 'returns the same instance for multiple calls to .instance' do
    instance1 = Singleton.instance
    instance2 = Singleton.instance
    expect(instance1.object_id).to eq(instance2.object_id)
  end

  it 'allows access to a shared attribute' do
    instance = Singleton.instance
    instance.data = "Updated data"
    expect(Singleton.instance.data).to eq("Updated data")
  end

  it 'does not allow direct instantiation via .new' do
    expect { Singleton.new }.to raise_error(NoMethodError)
  end

  it 'initializes the attribute with default data' do
    instance = Singleton.instance
    expect(instance.data).to eq("Default data")
  end
end
