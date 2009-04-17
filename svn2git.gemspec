# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{svn2git}
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Coglan", "Kevin Menard"]
  s.date = %q{2009-04-17}
  s.default_executable = %q{svn2git}
  s.email = %q{nirvdrum@gmail.com}
  s.executables = ["svn2git"]
  s.extra_rdoc_files = [
    "ChangeLog.markdown",
    "README.markdown"
  ]
  s.files = [
    "ChangeLog.markdown",
    "README.markdown",
    "Rakefile",
    "VERSION.yml",
    "bin/svn2git",
    "lib/svn2git.rb",
    "lib/svn2git/migration.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{https://www.negativetwenty.net/redmine/projects/svn2git}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{A tool for migrating svn projects to git}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
