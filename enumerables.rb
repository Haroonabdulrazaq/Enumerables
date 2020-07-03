# module custom Enumerables
module Enumerable
  # My Each Method

  def my_each
    return to_enum unless block_given?

    length.times do |i|
      yield(self[i])
    end
  end

  # My  Each_with_index
  def my_each_with_index
    return to_enum unless block_given?

    length.times do |i|
      yield(i, self[i])
    end
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

  # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
  # My  All
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
    elsif Regexp
      my_each do |i|
        return false if args.match(i)
      end
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
  # rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity

  # My Count
  def my_count(num = 0)
    return size unless block_given? || num.zero?

    counter = 0
    my_each do |i|
      counter += 1 if yield(i)
    end
    counter
  end

  # My Inject Method
  def my_inject
    return to_enum unless block_given?

    result = self[0]
    (0...length - 1).times do |i|
      result = yield(result, self[i + 1])
    end
    result
  end

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
end

# Use multipliyer with inject ymethod
def multiply_els(arra)
  return to_enum unless block_given?

  arra.my_inject do |i, j|
    i * j
  end
end
