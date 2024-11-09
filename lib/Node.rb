class Node
  attr_accessor :value, :next, :key
  def initialize(key = nil, value = nil)
    self.key = key
    self.value = value
    self.next = nil
  end
end