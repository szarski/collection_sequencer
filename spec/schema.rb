ActiveRecord::Schema.define :version => 0 do

  create_table "collection_sequences", :force => true do |t|
    t.string   "name"
    t.text     "id_list"
    t.integer  "context_id"
    t.string   "context_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
