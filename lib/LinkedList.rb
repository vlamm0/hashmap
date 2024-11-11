require_relative 'Node'


class LinkedList
  attr_accessor :head

  def initialize()
    self.head = nil
  end

  # method to crawl up the list using a condition set by the calling methods with yield
  # returns desired node or size of list
  def crawl(size = false)
    curr = head
    nodes = 1
    while yield(curr, nodes)
      curr, nodes = curr.next, nodes + 1
    end
    size ? nodes : curr
  end
  
  def append(key, value)
    if head.nil?
      @head = Node.new(key, value)
    else
      tail = crawl {|curr| !curr.next.nil?}
      tail.next = Node.new(key, value)
    end
  end

  def find(key)
    curr = crawl("index") do |curr|
      break if curr.nil?
      curr.key != key
    end
    curr ? curr - 1 : nil
  end

  def at(index)
    raise "***index must be positive***" if index < 0
    curr = crawl {|curr, nodes| index >= nodes }
    curr ? curr : "index #{index} out of range"
  end

  def remove_at(index)
    index == 0 ? @head = head.next : at(index-1).next = at(index+1)
    head
  end

  def size
    crawl("nodes") { |curr| !curr.next.nil?}
  end

  def enum
    curr = head
    list = []
    while !curr.nil?
      list << yield([curr.key, curr.value])
      curr = curr.next
    end
    list
  end
end