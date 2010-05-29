require 'migration'

migration = Svn2Git::Migration.new(ARGV)
migration.run!