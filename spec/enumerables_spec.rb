require './enumerables.rb'

describe Enumerable do 

    describe "#my_each" do
        it "returns self, if a block is given" do
            enum = Array.new
            expect(enum.my_each {|x| x}).to eql(enum)
        end

        it "returns enumerator, if block is not given" do
            enum = [1,2,5]
            expect(enum.my_each.is_a?(Enumerable)).not_to be false
        end
    end
end
