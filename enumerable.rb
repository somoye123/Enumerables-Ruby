module Enumerable
  def my_each
    each do |i|
      yield i
    end
  end
end

test_array = [1, 2, 3, 4, 5]

# test_array.my_each { |i| puts i * 2}

# test_array.my_each_with_index { |i, j| puts "#{j} is the index while #{i} is the value" }

# puts test_array.my_select(&:even?)

# test_array.my_all? { |number| number >= 1 }

# test_array.my_all? { |number| number >= 1 }