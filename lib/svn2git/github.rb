module Svn2Git
  module GitHub
  
    def self.push(migration, options = {})
      dir = migration.dir
      run = "cd #{dir} &&"
      `#{run} git remote add origin git@github.com:#{options[:to]}.git`
      `#{run} git push origin master`
      `#{run} git push --all`
      `#{run} git push --tags`
    end
  
  end
end

