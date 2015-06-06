require 'rake/testtask'

task default: %w[test]

task :test do |t|
  t.libs << "tests"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end
