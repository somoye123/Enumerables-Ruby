module Enumerable
  def my_each
    each do |i|
      yield i
    end
  end

  def my_each_with_index
    count = 0
    while count < length
      yield(self[count], count)
      count += 1
    end
  end

  def my_select
    filtered_array = []
    each do |i|
      filtered_array.push(i) if yield i
    end
    filtered_array
  end

  def my_all?
    each do |i|
      return puts false unless yield i
    end
    puts true
  end

  def my_any?
    each do |i|
      return true if yield i
    end
    false
  end

  def my_none?
    each do |i|
      return false if yield i
    end
    true
  end

  def my_count
    length
  end

  def my_map(some_proc = nil)
    mapped_array = []
      each do |i|
        mapped_array.push(yield i)
      end
    end
    mapped_array
  end

  def my_inject(initial_value = nil)
    acc = initial_value
    each do |i|
      if acc.nil?
        acc = i
        next
      end
      acc = yield(acc, i)
    end
    acc
  end
end

def multiply_els(arr)
  puts(arr.my_inject { |a, b| a * b })
end

test_array = [1, 2, 3, 4, 5]

# test_array.my_each { |i| puts i * 2}

# test_array.my_each_with_index { |i, j| puts "#{j} is the index while #{i} is the value" }

# puts test_array.my_select(&:even?)

# test_array.my_all? { |number| number >= 1 }

# puts(test_array.my_any? { |number| number <= 1 })

# puts(test_array.my_none? { |number| number < 1 })

# puts test_array.my_count

# puts(test_array.my_map { |i| i * 2 })
# test_array.inject

# puts((5..10).my_inject { |sum, n| sum + n } )

# multiply_els([2, 4, 5])

# puts [1, 2, 3, 4, 5].my_map(Proc.new { |a| a*2 }) { |i| i*3 }

# puts [1,2,3,4,5].my_map() { |i| i**3}