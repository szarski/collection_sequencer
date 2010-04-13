# Include hook code here
require File.join(File.dirname(__FILE__), 'lib', 'collection_sequencer')
require File.join(File.dirname(__FILE__), 'lib', 'array_extension')
require File.join(File.dirname(__FILE__), 'app/models', 'collection_sequence')
CollectionSequencer.initialize
