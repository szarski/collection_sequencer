require 'rake'
require 'rake/rdoctask'
require 'spec'
require 'spec/rake/spectask'

desc 'Default: run rspec tests.'
task :default => :rspec

desc 'Test the collection_sequencer plugin.'
Spec::Rake::SpecTask.new(:rspec) do |t|
  t.spec_opts = ['--options', "\"spec/spec.opts\""]
  t.spec_files = FileList['spec/collection_sequencer/*.rb']
end

desc 'Generate documentation for the collection_sequencer plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'CollectionSequencer'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
