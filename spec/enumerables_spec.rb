require './enumerables.rb'

describe Enumerable do 
    let (:arr) {[1,2,5]}   
    let (:my_arr) {[]}
    let (:original_arr ) {[]}
    let (:hash) {{"javaScript": 2018, "PHP": 2002, "java": 1995}}
    let (:my_hash) {[]}
    let (:original_hash) {[]}

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
end


  