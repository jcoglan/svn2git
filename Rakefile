require 'rake'
require 'rake/gempackagetask'

spec = Gem::Specification.new do |spec| 
  spec.name = "svn2git"
  spec.version = "1.0.0"
  spec.platform = Gem::Platform::RUBY
  spec.summary = "A tool for migrating svn projects to git"
  
  spec.require_path = "lib"
  spec.files = FileList["lib/**/*"].to_a
  spec.autorequire = "lib/svn2git.rb"
  spec.bindir = "bin"
  spec.executables = ["svn2git"]
  spec.default_executable = "svn2git"
  
  spec.author = "James Coglan"
  spec.email = "james@jcoglan.com"
  spec.homepage = "http://github.com/jcoglan/svn2git/"
  
  spec.test_files = FileList["test/**/*"].to_a
  spec.has_rdoc = true
  spec.extra_rdoc_files = ["README"]
  spec.rdoc_options << "--main" << "README" << '--line-numbers' << '--inline-source'
end
 
Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end

