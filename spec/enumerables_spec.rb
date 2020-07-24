require './enumerables.rb'

describe Enumerable do 
    let (:enum) {[1,2,5]}
      
    context "#my_each" do
        it "returns self, if a block is given" do
            expect(enum.my_each {|x| x}).to eql(enum)
        end

        it "returns enumerator, if block is not given" do
            expect(enum.my_each.is_a?(Enumerable)).not_to be false
        end
    end
end
