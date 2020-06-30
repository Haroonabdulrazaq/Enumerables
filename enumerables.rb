module Enumerable
 #My Each Method
  def my_each 
    for i in 0...self.length
      yield(self[i])
    end
  end


 #My  Each_with_index
def my_each_with_index 
   for i in 0...self.length
    yield(i,self[i])
      end
    end


 #My Select Method
    def my_select
        invited_list =[]
          self.my_each do |friend|
            if yield(friend)
              invited_list.push(friend)
            end
          end   
          return invited_list      
    end


 #My  All
def my_all?
    check = false
    self.my_each do |i|
        if yield(i) == true
            check = true
        else
            check = false
            return check
         end
    end
    return check
end

 #My None
def my_none?
    check = false
    self.my_each do |i|
        if yield(i) == true
            check = false
            return check
        else
            check = true
        end
    end
    return check
end
 
 #My Count
def my_count
  counter =0
  self.my_each do |i|
    if yield(i)
      counter += 1
    end
  end
  counter
end

#My Inject
def my_inject
    result = self[0]
    for i in 0...self.length-1
    result = yield(result,self[i+1])
  end
  return result
end
 
#My  my_map with condition of Proc and Block
 def my_map(proc = nil)
  result =[]
    if proc
      self.my_each do |i|
        result.push(proc.call(i))
      end
    else
      self.my_each do |i|
        result.push(yield(i))
      end
    end
    return result
  end


end

 #Use multipliyer with inject method
def multiply_els(arra)
    arra.my_inject do |i , j|
        i * j
    end
end
