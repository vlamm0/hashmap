
require_relative 'Node'
require_relative 'LinkedList'

class HashMap
  attr_accessor :buckets

  def initialize
    self.buckets = Array.new(16, nil)
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord}
    hash_code % 16
  end

  def set(key, value)
    index = hash(key)
    buckets[index] = LinkedList.new() if buckets[index].nil?
    bucket = buckets[index]
    node = bucket.find(key)
    node.nil? ? bucket.append(key, value) : bucket.at(node).value = value
  end

  def get(key)
    bucket = buckets[hash(key)]
    bucket.nil? ? nil : bucket.at(bucket.find(key)).value
  end
end
