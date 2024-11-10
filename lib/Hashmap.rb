
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
    bucket = buckets[hash(key)]
    node = bucket.find(key)
    node.nil? ? bucket.append(key, value) : bucket.at(node).value = value
  end

  def get(key)
    bucket = buckets[hash(key)]
    bucket.nil? ? nil : bucket.at(bucket.find(key)).value
  end

  #checks bucket for nil then checks for key
  def has?(key)
    bucket = buckets[hash(key)]
    bucket.nil? ? false : !bucket.find(key).nil?
  end

  def remove(key)
    #find key (or return nil) in hashmap
    bucket = buckets[hash(key)]
    return nil if bucket.nil? 
    index = bucket.find(key)
    
    value = bucket.at(index).value
    buckets[hash(key)] = nil if bucket.remove_at(index).nil?
    #this is wrong if there is more than one item in list, need to work at LL level
    #index == 0 ? buckets[hash(key)] = nil : bucket.remove_at(index)
    #remove key if exists
    #return key or nil
    
    value
  end
end

