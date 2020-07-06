# module custom Enumerables
# rubocop:disable Metrics/ModuleLength
module Enumerable
  # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/MethodLength
  # My Each Method

  def my_each
    return to_enum unless block_given?

    if is_a? Array
      length.times do |i|
        yield(self[i])
      end
    elsif is_a? Range
      arr = collect.to_a
      arr.length.times do |i|
        yield(arr[i])
      end
    end
    self
  end

  # My  Each_with_index
  def my_each_with_index
    return to_enum unless block_given?

    arr = []
    if is_a? Array
      length.times do |i|
        yield(self[i], i)
      end
    elsif is_a? Range
      arr = collect.to_a
      arr.my_each { |i| "#{arr[i]}  #{i}" }
    end
    self
  end

  # My Select Method
  def my_select
    return to_enum unless block_given?

    invited_list = []
    my_each do |friend|
      invited_list.push(friend) if yield(friend)
    end

    invited_list
  end

  # My  All
  # rubocop:disable Metrics/AbcSize

  def my_all?(args = nil)
    if block_given?
      my_each do |element|
        return false if yield(element) == false
      end
    elsif args.nil?
      my_each do |i|
        return false if i.nil?
      end
    elsif args.nil? && (args.is_a? Class)
      return false
    elsif !args.nil? && (args.is_a? Class)
      return true
    elsif !block_given? && !args.nil?
      return false
    elsif Regexp
      my_each do |i|
        return true if args.match(i)
      end
      return false
    end
    true
  end

  def my_any?(args = nil)
    check = false
    is_true = false
    if block_given?
      my_each do |i|
        if yield(i) == true
          check = true
          return check
        else
          check = false
        end
      end
      return check
    elsif args.class == Regexp
      my_each do |i|
        return true if i.match(args)

        return false
      end
    elsif !args.nil? && (args.is_a? Class)
      my_each do |i|
        if i.is_a? args
          is_true = true
          return true
        else
          is_true = false
        end
      end
      return is_true
    elsif !(args.is_a? Class) && args != Regexp
      my_each do |x|
        return true if x == args
      end
      return false
    end
    unless block_given?
      my_each { |x| return true if x == true }
      return false
    end
    false
  end

  def my_none?(args = nil)
    if block_given?
      check = false
      my_each do |element|
        if yield(element) == false
          check = true
        else
          check = false
          return check
        end
      end
      return check
    elsif !args.nil? && (args.is_a? Class)
      my_each do |i|
        return false if i.is_a? args
      end
    elsif args.class == Regexp
      my_each do |i|
        return false if i.match(args)

        return true
      end
    end
    unless block_given?
      my_each { |x| return false if x == true }
      return true
    end
    false
  end

  # My Inject
  def my_inject(param = nil, sym = nil)
    arra = []
    arra = collect.to_a
    return LocalJumpError if !block_given? && param.nil?

    if block_given? && param.nil?
      if is_a? Range
        sum = arra[0]
        (arra.length - 1).times do |i|
          sum = yield(sum, arra[i + 1])
        end
        sum
      else
        result = self[0]
        (length - 1).times do |i|
          result = yield(result, self[i + 1])
        end
        result
      end
    elsif block_given? && !param.nil?
      if is_a? Range
        sum = arra[0]
        (arra.length - 1).times do |i|
          sum = yield(sum, arra[i + 1])
        end
        sum
      else
        result = self[0]
        (length - 1).times do |i|
          result = yield(result, self[i + 1])
          return result
        end
      end
    elsif param.is_a? Symbol
      sum = arra[0]
      symb = param.to_sym
      (arra.length - 1).times do |i|
        sum = sum.send(symb, arra[i + 1])
      end
      sum
    elsif sym.is_a? Symbol
      sum = arra[0]
      symb = sym.to_sym
      (arra.length - 1).times do |i|
        sum = sum.send(symb, arra[i + 1])
      end
      sum
    end
  end

  def my_count(num = nil)
    counter = 0
    if !num.nil?
      my_each { |i| counter += 1 if num == i }
    elsif block_given?
      my_each do |i|
        counter += 1 if yield(i)
      end
    else return size
    end
    counter
  end

  # My Count

  # My  my_map with condition of Proc and Block
  def my_map(proc = nil)
    return to_enum unless block_given?

    result = []
    if proc
      my_each do |i|
        result.push(proc.call(i))
      end
    else
      my_each do |i|
        result.push(yield(i))
      end
    end
    result
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/ModuleLength
  # rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/MethodLength
end

# Use multipliyer with inject ymethod
def multiply_els(arra)
  arra.my_inject do |i, j|
    i * j
  end
end
