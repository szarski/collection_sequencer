class CollectionSequencerGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template "create_collection_sequences.rb", "db/migrate", :migration_file_name => 'create_collection_sequences'
    end
  end
end
