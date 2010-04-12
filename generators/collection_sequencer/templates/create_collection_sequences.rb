class CreateCollectionSequences < ActiveRecord::Migration
  def self.up
    create_table :collection_sequences do |t|
      t.string :name
      t.text :id_list
      t.references :context, :polymorphic => true

      t.timestamps
    end
  end

  def self.down
    drop_table :collection_sequences
  end
end
