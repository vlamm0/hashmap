
require_relative 'Node'
require_relative 'LinkedList'

class HashMap
  attr_accessor :buckets, :load_factor, :size

  def initialize
    self.buckets = Array.new(16, nil)
    self.load_factor = 0.75
    self.size = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord}
    hash_code % buckets.length
  end

  # expands the hashmap
  def grow
    items = entries
    self.buckets = Array.new(buckets.length * 2, nil)
    self.size = 0
    items.each {|item| set(item[0], item[1])}
  end

  def capacity
    (buckets.length * load_factor)
  end

  # sets a node into hashmap, creating a linkedlist if empty bucket
  def set(key, value)
    grow if (size + 1) > capacity
    index = hash(key)
    buckets[index] = LinkedList.new() if buckets[index].nil?
    bucket = buckets[index]
    node = bucket.find(key)
    node.nil? ? bucket.append(key, value) && self.size += 1 : bucket.at(node).value = value
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
    
    # removes appropriate node, empties bucket (remove linked list) if necessary
    buckets[hash(key)] = nil if bucket.remove_at(index).nil?
    value
  end

  def length
    size
  end

  def clear
    buckets.length.times do |i|
      buckets[i] = nil
    end
  end

  def keys
    entries(0)
  end

  def values
    entries(1)
  end

  # saves all nodes as k/v pairs in a 2d arr, helpful for storing before expansion  
  def entries(item = nil)
    list = []
    if item.nil?
      buckets.each {|bucket| list.concat(bucket.enum {|node_vars| node_vars}) unless bucket.nil?}
    else
      buckets.each {|bucket| list.concat(bucket.enum {|node_vars| node_vars[item]}) unless bucket.nil?}
    end
    list
  end
end

