require './enumerables.rb'

describe Enumerable do
  let(:arr) { [1, 2, 5, 2, 1, 2] }
  let(:my_arr) { [] }
  let(:original_arr) { [] }
  let(:bool_arr) { [true, true, 1, 99] }
  let (:bool_mix_arr) {[nil, false, true]}
  let(:word_arr) { %w[cat car can cut] }
  let(:hash) { { "javaScript": 2018, "PHP": 2002, "java": 1995 } }
  let(:my_hash) { [] }
  let(:original_hash) { [] }
  let(:my_result) { 0 }
  let(:original_result) { 0 }

  describe '#my_each' do
    context 'If block is given' do
      it 'Iterate over array and returns the iterated array' do
        arr.my_each { |x| my_arr << x }
        arr.each { |y| original_arr << y }
        expect(my_arr).to eql(original_arr)
      end

      it 'Iterate over hash and returns the iterated hash' do
        hash = hash.to_a
        hash.my_each { |key| my_hash << key }
        hash.each { |key| original_hash << key }
        expect(my_hash).to eql(original_hash)
      end
    end

    context 'If block not given' do
      it 'returns enum if block is not given' do
        expect(arr.my_each.is_a?(Enumerable)).not_to be false
      end
    end
  end

  describe '#my_each_with_index' do
    context 'If block is given' do
      it 'Iterate over array and returns the iterated array' do
        arr.my_each_with_index { |x, i| my_arr << x + i }
        arr.each_with_index { |y, i| original_arr << y + i }
        expect(my_arr).to eql(original_arr)
      end

      it 'Iterate over hash and returns the iterated hash' do
        hash = hash.to_a
        hash.my_each_with_index { |_element, _index| my_hash << key }
        hash.each_with_index { |_element, _index| original_hash << key }
        expect(my_hash).to eql(original_hash)
      end
    end

    context 'If block not given' do
      it 'returns enum if block is not given' do
        expect(arr.my_each_with_index.is_a?(Enumerable)).not_to be false
      end
    end
  end

  describe '#my_count' do
    context 'when block is not given' do
      it 'returns the number of element in the array' do
        my_result = arr.my_count
        original_result = arr.count
        expect(my_result).to eql(original_result)
      end

      it 'If argument is given returns the number of element that match the argument' do
        my_result = arr.my_count(2)
        original_result = arr.count(2)
        expect(my_result).to eql(original_result)
      end
    end
    context 'If block is given' do
      it 'returns element that matches the condition in the block' do
        my_result = arr.my_count(&:even?)
        original_result = arr.count(&:even?)
        expect(my_result).to eql(original_result)
      end
    end
  end

  describe '#my_select' do
    context 'if block given' do
      it 'returns element that match the test in block' do
        arr.my_select { |x| my_arr << x.even? }
        arr.select { |x| original_arr << x.even? }
        expect(my_arr).to eql(original_arr)
      end
    end

    context 'If block not given' do
      it 'returns an enumerator' do
        expect(arr.my_select.is_a?(Enumerable)).not_to be false
      end
    end
  end

  describe '#my_all?' do
    context 'If block given' do
      it 'returns all element that passes the block condition' do
        my_result = word_arr.my_all? { |word| word.length <= 3 }
        original_result = word_arr.all? { |word| word.length <= 3 }
        expect(my_result).to eql(original_result)
      end
    end

    context 'if arguments given' do
      it 'returns true for all element that matches the regexp' do
        my_result = word_arr.my_all?(/c/)
        original_result = word_arr.all?(/c/)
        expect(my_result).to eql(original_result)
      end

      it 'returns true if all element matches the Class' do
        my_result = arr.my_all?(Numeric)
        original_result = arr.all?(Numeric)
        expect(my_result).to eql(original_result)
      end
    end

    context 'if argument is nil' do
      it 'returns true is none returns false' do
        my_result = bool_mix_arr.my_all?
        original_result = bool_mix_arr.all?
        expect(my_result).to eql(original_result)
      end
    end
  end

  describe '#my_any?' do
    context 'If a block is given' do
      it 'returns true when any of the element is true' do
        my_result = word_arr.my_any? { |word| word.length >= 3 }
        original_result = word_arr.any? { |word| word.length >= 3 }
        expect(my_result).to eql(original_result)
      end
    end

    context 'If block is not given' do
      it 'returns true if any element matches the regexp' do
        my_result = word_arr.my_any?(/c/)  
        original_result = word_arr.any?(/c/)  
        expect(my_result).to eql( original_result)
      end
      it 'returns true if any element matches the class' do
        my_result = bool_arr.my_any?(TrueClass)
        original_result =  bool_arr.any?(TrueClass)
        expect(my_result).to eql( original_result)
      end
      it 'returns true if any element is true and argument is nil' do
        my_result = arr.my_any?
        original_result = arr.any?
        expect(my_result).to eql(original_result)
      end
    end
  end

  describe '#my_none?' do
    context 'If a block is given' do
      it 'returns false when any of the element is true' do
        my_result = word_arr.my_none? { |word| word.length >= 3 }
        original_result = word_arr.none? { |word| word.length >= 3 }
        expect(my_result).to eql(original_result)
      end
    end

    context 'If block is not given' do
      it 'returns false if any element matches the regexp' do
        my_result = word_arr.my_none?(/c/)
        original_result = word_arr.none?(/c/)
        expect(my_result).to eql(original_result)
      end
      it 'returns false if any element matches the class' do
        my_result = bool_arr.my_none?(TrueClass)
        original_result = bool_arr.none?(TrueClass)
        expect(my_result).to eql(original_result)
      end
      it 'returns false if any element is true and argument is nil' do
        my_result = arr.my_none?
        original_result = arr.my_none?
        expect(my_result).to eql(original_result)
      end
    end
  end

  describe '#my_inject' do
    context 'If no block is given' do
      it 'returns the sum of all elements' do
        my_result = arr.my_inject(:+)
        original_result = arr.inject(:+)
        expect(my_result).to eql(original_result)
      end
      it 'returns the product of all elements' do
        my_result = arr.my_inject(1, :*)
        expect(my_result).to eql(arr.inject(1, :*))
      end
    end
    context 'If a block is given' do
      it 'returns the product of all elements multiplied with the argument' do
        my_result = arr.my_inject(1) { |product, n| product * n }
        original_result = arr.inject(1) { |product, n| product * n }
        expect(my_result).to eql(original_result)
      end
      it 'returns the sum of all elements' do
        my_result = arr.my_inject { |sum, n| sum + n }
        original_result = arr.inject { |sum, n| sum + n }
        expect(my_result).to eql(original_result)
      end
    end
  end

  describe '#my_map' do
    it 'returns a modified array of element' do
      my_result = arr.my_map { |x| x * 3 }
      original_result = arr.map { |x| x * 3 }
      expect(my_result).to eql(original_result)
    end

    it 'returns a modified array if proc is given' do
      square = proc { |x| x**2 }
      expect(arr.my_map(&square)).to eql(arr.map(&square))
    end
  end

  describe '#multiply_els' do
    it 'returns the prodecuts of elements in the array' do
      expect(multiply_els(arr)).to eql(40)
    end
  end
end
