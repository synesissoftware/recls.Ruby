# Rakefile for recls

require 'rake/testtask'


Rake::TestTask.new do |tt|

  tt.libs << "lib"
  tt.name = "test"
  tt.test_files = FileList['test/**/tc_*.rb']
  tt.verbose = true
end


task :default => :test


# ############################## end of file ############################# #
