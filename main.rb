require_relative 'lib/Hashmap'

test = HashMap.new
test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('elephant', 'red')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

# adds multiple items to a bucket to test the logic
# cannot be removed with method because it is being entered manually (not hashed)
# to delete this line after testing to remove
test.buckets[1].append("test", "test")
p test.get('elephant')
p test.has?('ice cream')
p test.has?('num')
p test
p test.remove('elephant')
p test.remove('carrot')
p test 

p test.length
puts "TOO MANY BUCKETS" if test.buckets.length > 16

test.clear 
p test.length
p test