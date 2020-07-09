module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    each do |i|
      yield i
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    count = 0
    while count < length
      yield(self[count], count)
      count += 1
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    filtered_array = []
    each do |i|
      filtered_array.push(i) if yield i
    end
    filtered_array
  end

  def my_all?(arg = nil)
    return to_enum(:my_all) unless block_given?

    if block_given?
      each do |i|
        return false unless yield i
      end
    elsif !arg.nil? && arg.class == Regexp
      each do |i|
        return false unless arg.match(i)
      end
    elsif !arg.nil? && arg.class == Array
      each do |i|
        return false unless i.class == arg.class
      end
    else
      each do |i|
        return false unless i == arg
      end
    end
    true
  end

  def my_any?
    return to_enum(:my_any) unless block_given?

    if block_given?
      each do |i|
        return true if yield i
      end
    elsif !arg.nil? && arg.class == Regexp
      each do |i|
        return true if arg.match(i)
      end
    elsif !arg.nil? && arg.class == Array
      each do |i|
        return true if i.class == arg.class
      end
    else
      each do |i|
        return true if i == arg
      end
    end
    false
  end

  def my_none?
    return to_enum(:my_none) unless block_given?

    if block_given?
      each do |i|
        return false if yield i
      end
    elsif !arg.nil? && arg.class == Regexp
      each do |i|
        return false if arg.match(i)
      end
    elsif !arg.nil? && arg.class == Array
      each do |i|
        return false if i.class == arg.class
      end
    else
      each do |i|
        return false if i == arg
      end
    end
    true
  end

  def my_count(arg = nil)
    count = 0
    if block_given?
      each do |i|
        count += 1 if yield i
      end
    elsif !arg.nil? && arg.class == Regexp
      each do |i|
        count += 1 if arg.match(i)
      end
    elsif !arg.nil? && arg.class == Array
      each do |i|
        count += 1 if i.class == arg.class
      end
    else
      each do |i|
        count += 1 if i == arg
      end
    end
    arg.nil? ? length : count
  end

  def my_map(some_proc = nil)
    return to_enum(:my_map) unless block_given?

    mapped_array = []
    if some_proc
      each do |i|
        mapped_array.push(some_proc.call(i))
      end
    else
      each do |i|
        mapped_array.push(yield i)
      end
    end
    mapped_array
  end

  def my_inject(*args)
    initial_value, symbol = args
    acc = initial_value if initial_value.class == Integer
    sym = nil

    if symbol
      sym = symbol
    elsif initial_value.class == Symbol || String
      sym = initial_value
    end

    if block_given?
      each do |i|
        if acc.nil?
          acc = i
          next
        end
        acc = yield(acc, i)
      end
    elsif !sym.nil? && sym.class == Symbol
      each do |i|
        if acc.nil?
          acc = i
          next
        end
        acc = acc.send(sym, i)
      end
    elsif !sym.nil? && sym.class == String && %r{[+-/*]}.match(sym)
      each do |i|
        if acc.nil?
          acc = i
          next
        end
        acc = acc.send(sym, i)
      end
    end

    acc
  end
end

def multiply_els(arr)
  (arr.my_inject { |a, b| a * b })
end

test_array = [1, 2, 3, 4, 5]

test_array.my_each { |i| puts i * 2 }

test_array.each_with_index { |i, j| puts "#{j} is the index while #{i} is the value" }

puts test_array.my_select(&:even?)

test_array.my_all? { |number| number >= 1 }

puts(test_array.my_any? { |number| number <= 1 })

puts(test_array.my_none? { |number| number < 1 })

puts test_array.my_count

puts(test_array.my_map { |i| i * 2 })

puts((5..10).my_inject { |sum, n| sum + n })

multiply_els([2, 4, 5])

puts [1, 2, 3, 4, 5].my_map(proc { |a| a * 2 }) { |i| i * 3 }

puts([1, 2, 3, 4, 5].my_map { |i| i**3 })
