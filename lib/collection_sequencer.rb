# CollectionSequencer
module CollectionSequencer
  def self.initialize
    ActiveRecord::Base.class_eval do
      def self.sequencable_collection
        table_name = self.table_name
        named_scope :apply_collection_sequence, lambda{|collection_sequence| (!collection_sequence or collection_sequence.ids.empty?) ? {} : {:order => collection_sequence.sql_order_statement(table_name)}}
        self.extend CollectionSequencer::ClassMethods
      end
    end
  end

  module ClassMethods
    def sequenced(collection_sequence)
      block = lambda {|result| collection_sequence.extend_ids_to_collection!(result)}
      return Callbacker.new(self.apply_collection_sequence(collection_sequence), block, {:termination_methods => self.scopes.keys, :reverse => true})
    end
  end
end
