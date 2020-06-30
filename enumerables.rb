# frozen_string_literal: true

module Enumerable
  def my_each 
    for i in 0...self.length
      yield(self[i])
    end
  end
  [1, 2, 3, 6, 5].my_each { |i| puts i }

def my_each_with_index 
   for i in 0...self.length
    yield(i,self[i])
      end
    end
    [7, 9, 33, 61, 15].my_each_with_index { |i, element| puts "#{i} " "#{element}" }

    def my_select
        invited_list =[]
          self.my_each do |friend|
            if yield(friend)
              invited_list.push(friend)
            end
          end   
          return invited_list      
    end
    not_invited = "Talha"
puts ["Haroon","Umair","Talha", "Jaqob","Asahad"].my_select { |friend| friend != not_invited}

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
puts "\n"
puts ["Haroon","Umair","Talhaaaa", "Jaqob","Asahad"].my_all? { |friend| friend.length < 7}

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

puts "\n"
puts ["Haroon","Umair","Talha", "Jaqob","Arshad"].my_none? { |friend| friend.length > 7}


def my_count
  counter =0
  self.my_each do |i|
    if yield(i)
      counter += 1
    end
  end
  counter
end
puts [1,4,2,4,2].my_count { |element| element%2 == 0} 
 

puts "My Inject"

def my_inject
    result = self[0]
    for i in 0...self.length-1
    result = yield(result,self[i+1])
  end
  return result
end
 puts [1,2,3,4].my_inject { |sum, n| sum - n } 


#  def my_map(prock)
#     result =[]
#     self.my_each do |i|
#       result.push(prock.call(i))
#     end
#     return result
#   end
 


  puts "Proc with condition"
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
  puts "Proc test \n" 
  result_proc = Proc.new {|x| x * 3 }
  puts [1,2,3,4].my_map(result_proc)
  puts "Proc end \n"

  



 puts "multiply_els "

# puts multiply_els([1,2,3])

end
def multiply_els(arra)
    arra.my_inject do |i , j|
        i * j
    end
end
puts multiply_els([2,4,5])