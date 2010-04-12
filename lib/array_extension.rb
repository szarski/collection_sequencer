class Array
  def update_subarray_sequence(new_array)
    new_index = 0
    original = self.clone
    self.each_with_index do |element, index|
      if new_array.include?(element)
        original[index] = new_array[new_index]
        new_index += 1
      end
    end
    return original
  end
end
