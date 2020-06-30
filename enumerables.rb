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
end