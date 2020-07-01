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

  # My  All
  def my_all?
    return to_enum unless block_given?

    check = false
    my_each do |i|
      if yield(i) == true
        check = true
      else
        check = false
        return check
      end
    end
    check
  end



  # My None
  def my_none?
    return to_enum unless block_given?

    check = false
    my_each do |i|
      if yield(i) == true
        check = false
        return check
      else
        check = true
      end
    end
    check
  end

  # My Count
  def my_count(num=0)
    return self.size unless block_given? || num == 0
    
    counter = 0
    my_each do |i|
      counter += 1 if yield(i)
    end
    counter
  end


  # My Inject
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
