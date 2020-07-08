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

test_array.inj