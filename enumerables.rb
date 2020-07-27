# module custom Enumerables
# rubocop:disable Metrics/ModuleLength
module Enumerable
  # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/MethodLength
  # My Each Method

  def my_each
    return to_enum unless block_given?

    arra = is_a?(Array) ? self : to_a
    arra.length.times do |i|
      yield(arra[i])
    end
    self
  end

  # My  Each_with_index
  def my_each_with_index
    return to_enum unless block_given?

    arr = is_a?(Array) ? self : to_a
    arr.length.times do |i|
      yield(arr[i], i)
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
        return false if i == false || i.nil?
      end
    elsif !args.nil? && (args.is_a? Class)
      my_each do |i|
        return false unless i.is_a? args
      end
    elsif !args.nil? && args.class == Regexp
      my_each do |i|
        return false unless args.match(i)
      end
    else
      my_each do |i|
        return false if i != args
      end
    end
    true
  end

  # my_Any
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
      if !args.nil?
        my_each do |i|
          return true if i == args
        end
        return false
      else
        mah_chk = false
        my_each do |i|
          if i.nil? || i == false
            mah_chk = false
          else
            mah_chk = true
            return true
          end
        end
        return mah_chk
      end
    end
    unless block_given?
      my_each { |x| return true if x == true }
      return false
    end
    false
  end

  def my_none?(obj = Object)
    out_value = true
    if block_given?
      my_each { |i| out_value = false if yield(i) }
    elsif obj.is_a?(Class)
      my_each { |i| out_value = false if i }
    elsif obj.is_a?(Regexp)
      my_each {|i| out_value = false if i}
    else
      my_each { |i| out_value = false if i == obj }
    end
    out_value
  end
  
  # My Inject
  # def my_inject(param = nil, sym = nil)
  #   arra = []
  #   arra = collect.to_a
  #   return raise LocalJumpError, 'no block given' if !block_given? && param.nil?

  #   if block_given? && param.nil?
  #     if is_a? Range
  #       sum = arra[0]
  #       (arra.length - 1).times do |i|
  #         sum = yield(sum, arra[i + 1])
  #       end
  #       sum
  #     else
  #       result = self[0]
  #       (length - 1).times do |i|
  #         result = yield(result, self[i + 1])
  #       end
  #       result
  #     end
  #   elsif block_given? && !param.nil?
  #     if is_a? Range
  #       sum = arra[0]
  #       (arra.length - 1).times do |i|
  #         sum = yield(sum, arra[i + 1])
  #       end
  #       sum = yield(sum, param)
  #       sum
  #     else
  #       result = self[0]
  #       (length - 1).times do |i|
  #         result = yield(result, self[i + 1])
  #         return result
  #       end
  #     end
  #   elsif param.is_a? Symbol
  #     sum = arra[0]
  #     symb = param.to_sym
  #     (arra.length - 1).times do |i|
  #       sum = sum.send(symb, arra[i + 1])
  #     end
  #     sum
  #   elsif sym.is_a? Symbol
  #     sum = arra[0]
  #     symb = sym.to_sym
  #     (arra.length - 1).times do |i|
  #       sum = sum.send(symb, arra[i + 1])
  #     end
  #     sum = sum.send(symb, param)
  #     sum
  #   end
  # end

  def my_inject(*args)
    if block_given? && args[0].nil?
      acc = to_a[0]
      to_a[1..-1].my_each { |i| acc = yield(acc, i) }
    elsif block_given?
      acc = args[0]
      my_each { |i| acc = yield(acc, i) }
    elsif args.size == 2
      acc = args[0]
      my_each { |i| acc = acc.send(args[1], i) }
    elsif args.size == 1
      acc = to_a[0]
      to_a[1..-1].my_each { |i| acc = acc.send(args[0], i) }
    end
    acc
  end

  # My_Count
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
