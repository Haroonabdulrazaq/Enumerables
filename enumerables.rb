# frozen_string_literal: true

module Enumerable
  def my_each
    (0...length).each do |i|
      yield(self[i])
    end
  end
  [1, 2, 3, 6, 5].my_each { |i| puts i }
end
