class CollectionSequence < ActiveRecord::Base
  attr_accessor :parent

  def initialize(params={})
    collection = params.delete :collection
    _ids = params.delete :ids
    super({})
    if _ids.is_a?(Array)
      self.ids = _ids
    elsif collection
      self.ids = collection.map(&:id)
    else
      self.ids = []
    end
  end

  def sorted_collection(collection)
    sub_collection = collection.reject {|element| !self.ids.include?(element.id)}
    sub_collection.sort {|one, two| self.ids.index(one.id) <=> self.ids.index(two.id)}
  end

  def update_sequence!(_ids)
    _ids.collect! {|x| x.to_i}
    self.extend_ids _ids
    self.ids = self.ids.update_subarray_sequence(_ids)
    self.save!
  end

  def ids
    (self.id_list || '').split(',').collect {|id| id.to_i}
  end

  def ids=(_ids)
    raise Exception.new('bad ids format') unless _ids.is_a?(Array)
    self.id_list = _ids.join(',')
  end

  def < (id)
    raise Exception.new('bad id format') unless id.to_s.match(/^[0-9]*$/)
    self.ids = self.ids + [id.to_i]
  end

  def sub_sequence
    return self.sub_sequence_with(nil)
  end

  def sub_sequence_with(_ids)
    new_ids = self.ids & _ids # we're keeping the order
    _sub_sequence = self.class.new(nil, new_ids)
    _sub_sequence.parent = self
    return _sub_sequence
  end

  def extend_ids_to_collection!(collection, position=:beginning)
    self.extend_ids_to_collection(collection, position)
    self.save!
  end
  def extend_ids_to_collection(collection, position=:beginning)
    _ids = collection.map(&:id)
    self.extend_ids(_ids, position)
  end

  def extend_ids(_ids, position=:beginning)
    missing_ids = _ids - self.ids
    if position == :beginning
      self.ids = missing_ids + self.ids
    else
      self.ids = self.ids + missing_ids 
    end
  end

  def sql_order_statement(table_name=nil)
    field_name = table_name ? "#{table_name}.id" : 'id'
    "FIELD(#{field_name}, #{self.ids.join(',')})"
  end

end
