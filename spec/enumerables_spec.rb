require './enumerables.rb'

describe Enumerable do 
    let (:arr) {[1,2,5]}   
    let (:hash) {{"javaScript": 2018, "PHP": 2002, "java": 1995}}
    describe "#my_each" do
        context "If block is given" do
            my_arr =[]
            original_arr = []
            it "Iterate over array and returns the iterated array" do
                arr.my_each{|x| my_arr << x}
                arr.each{|y| original_arr << y}
                expect(my_arr).to eql(original_arr)
            end

            it "Iterate over hash and returns the iterated hash" do
                my_hash =[]
                original_hash = []
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
end


  