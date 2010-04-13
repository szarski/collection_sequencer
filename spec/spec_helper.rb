require 'rubygems'
require 'active_record'
require 'spec'
require 'ruby-debug'
 
TEST_DATABASE_FILE = File.join(File.dirname(__FILE__), '..', 'test.sqlite3')
begin
  File.unlink(TEST_DATABASE_FILE) if File.exist?(TEST_DATABASE_FILE)
  
  ActiveRecord::Base.establish_connection("adapter" => "sqlite3", "database" => TEST_DATABASE_FILE)
  
  load(File.dirname(__FILE__) + '/schema.rb')
rescue Exception => e
  puts "\n\n  #{e.message}, backtrace:"#, e.backtrace
  raise Exception.new "\n\nTo run test you have to have sqlite3 installed:
  sudo apt-get install sqlite3 libsqlite3-dev
  sudo gem install sqlite3-ruby"
end
 
#"collection_sequencer.rb".split(' ').each do |filename|
  require File.join(File.dirname(__FILE__), '..', 'init.rb')
#end

Spec::Runner.configure do |config|
  def clear_database
    CollectionSequence.destroy_all
  end

end
