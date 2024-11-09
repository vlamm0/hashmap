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
  
  # check
  def append(key, value)
    if head.nil?
      @head = Node.new(key, value)
    else
      tail = crawl {|curr| !curr.next.nil?}
      tail.next = Node.new(key, value)
    end
  end

  def prepend(value)
    new_node = Node.new(value)
    new_node.next = head
    @head = new_node
  end

  def size
    crawl("nodes") { |curr| !curr.next.nil?}
  end

  def get_head
    head
  end

  def get_tail
    tail = crawl {|curr| !curr.next.nil?}
    tail
  end

  def at(index)
    raise "***index must be positive***" if index < 0
    curr = crawl {|curr, nodes| index >= nodes }
    curr ? curr : "index #{index} out of range"
  end

  def pop
    #next to last node
    at(size - 2).next = nil
  end

  def contains?(value)
    curr = crawl do |curr| 
      break if curr.nil? 
      curr.value != value
    end
    curr ? true : false
  end

  def find(value)
    curr = crawl("nodes") do |curr|
      break if curr.nil?
      curr.value != value
    end
    curr ? curr - 1 : nil
  end

  # displays value of every node
  def to_s
    crawl do |curr|
      print "( #{curr.value} ) -> "
      !curr.next.nil?
    end
    puts "nil"
  end

  # points prev to new_node, new_node points to index
  def insert_at(value, index)
    new_node = Node.new(value)
    new_node.next = at(index)
    at(index-1).next = new_node
  end

  # points prev node to node after index
  def remove_at(index)
    at(index-1).next = at(index+1)
  end
end