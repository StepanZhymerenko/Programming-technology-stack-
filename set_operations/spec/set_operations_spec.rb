require 'set_operations'

RSpec.describe SetOperations do
  it "об'єднання множин" do
    expect(SetOperations.union([1, 2], [2, 3])).to eq([1, 2, 3])
  end

  it "перетин множин" do
    expect(SetOperations.intersection([1, 2], [2, 3])).to eq([2])
  end

  it "різниця множин" do
    expect(SetOperations.difference([1, 2], [2, 3])).to eq([1])
  end
end
