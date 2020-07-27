require './enumerables.rb'

describe Enumerable do 
    let (:arr) {[1,2,5,2,1,2]}   
    let (:my_arr) {[]}
    let (:original_arr ) {[]}
    let (:hash) {{"javaScript": 2018, "PHP": 2002, "java": 1995}}
    let (:my_hash) {[]}
    let (:original_hash) {[]}
    let (:my_result) {0}
    let (:original_result) {0}


    describe "#my_each" do
        context "If block is given" do        
            it "Iterate over array and returns the iterated array" do
                arr.my_each{|x| my_arr << x}
                arr.each{|y| original_arr << y}
                expect(my_arr).to eql(original_arr)
            end

            it "Iterate over hash and returns the iterated hash" do
                hash = hash.to_a
                hash.my_each{|key| my_hash << key} 
                hash.each{|key| original_hash << key}
                expect(my_hash).to eql(original_hash)
            end
        end

        context "If block not given" do
            it "returns enum if block is not given" do
                expect(arr.my_each.is_a?(Enumerable)).not_to be false
            end
        end
    end

    describe "#my_each_with_index" do
        context "If block is given" do
            it "Iterate over array and returns the iterated array" do
                arr.my_each_with_index{|x, i| my_arr << x + i}
                arr.each_with_index{|y, i| original_arr << y + i}
                expect(my_arr).to eql(original_arr)
            end

            it "Iterate over hash and returns the iterated hash" do
                hash = hash.to_a
                hash.my_each_with_index{|element, index| my_hash << key} 
                hash.each_with_index{|element, index| original_hash << key}
                expect(my_hash).to eql(original_hash)
            end
        end

        context "If block not given" do
            it "returns enum if block is not given" do
                expect(arr.my_each_with_index.is_a?(Enumerable)).not_to be false
            end
        end
    end

    describe "#my_count" do
        context "when block is not given"  do
            it "returns the number of element in the array" do
                 my_result = arr.my_count
                 original_result = arr.count
                 expect(my_result).to eql(original_result)
            end

            it "If argument is given returns the number of element that match the argument" do
                 my_result = arr.my_count(2)
                 original_result = arr.count(2)
                 expect(my_result).to eql(original_result)
            end
        end
        context "If block is given" do
            it "returns element that matches the condition in the block" do
                my_result = arr.my_count{|x| x%2 ==0}
                original_result = arr.count{|x| x%2 ==0}
                expect(my_result).to eql(original_result)
            end
        end
    end

    describe "#my_select" do
        context "if block given" do
            it "returns element that match the test in block" do 
                arr.my_select{|x| my_arr << x.even?}
                arr.select{|x| original_arr << x.even?}
                expect(my_arr).to eql(original_arr)
            end
        end
    end 


    
end


  