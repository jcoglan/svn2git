module Svn2Git
  DEFAULT_AUTHORS_FILE = "~/.svn2git/authors"
  
  class Migration
  
    attr_reader :dir
    
    def initialize(url, options = {})
      @url = url
      @dir = @url.scan(/[^\/]+/).last
      
      @options = options
      @options[:trunk] ||= 'trunk'
      @options[:branches] ||= 'branches'
      @options[:tags] ||= 'tags'
      
      @authors = options[:authors]
      if @authors.nil? && File.exists?(File.expand_path(DEFAULT_AUTHORS_FILE))
        @authors = DEFAULT_AUTHORS_FILE
      end
    end
    
    def run!
      clone!
      fix_tags
      fix_branches
      fix_trunk
      optimize_repos
    end
    
  private
    
    def clone!
      trunk = @options[:trunk]
      branches = @options[:branches]
      tags = @options[:tags]
      rootistrunk = @options[:rootistrunk]
      
      if (!rootistrunk.nil?)
        # Non-standard repository layout.  The repository root is effectively 'trunk.'
        run_command("git svn init --no-metadata --trunk=#{@url}")
      
      else
        cmd = "git svn init --no-metadata "
        
        # Add each component to the command that was passed as an argument.
        cmd += "--trunk=#{trunk} " unless trunk.nil?
        cmd += "--tags=#{tags} " unless tags.nil?
        cmd += "--branches=#{branches} " unless branches.nil?
        
        cmd += @url
        
        run_command(cmd)
      end
      
      run_command("git config svn.authorsfile #{@authors}") if @authors
      run_command("git svn fetch")
      
      get_branches
    end
    
    def get_branches
      @branches = `git branch -a`.split(/\n/)
      @local = `git branch`.split(/\n/)
      @remote = @branches.find_all { |b| not @local.include?(b) }
      @tags = @remote.find_all { |b| b.strip =~ %r{^#{@options[:tags]}\/} }
    end
    
    def fix_tags
      @tags.each do |tag|
        id = tag.strip.gsub(%r{^#{@options[:tags]}\/}, '')
        subject = `git log -1 --pretty=format:"%s" #{tag.strip()}`
        date = `git log -1 --pretty=format:"%ci" #{tag.strip()}`
        `export GIT_COMMITER_DATE="#{date}"`
        run_command("git tag -a -m '#{subject}' '#{id.strip()}' '#{tag.strip()}^'")
        run_command("git branch -d -r #{tag.strip()}")
      end
    end
    
    def fix_branches
      svn_branches = @remote.find_all { |b| not @tags.include?(b) }
      svn_branches.each do |branch|
        branch = branch.strip
        next if branch == 'trunk'
        run_command("git checkout #{branch}")
        run_command("git checkout -b #{branch}")
      end
    end
    
    def fix_trunk
      trunk = @remote.find { |b| b.strip == 'trunk' }
      if trunk
        run_command("git checkout trunk")
        run_command("git branch -D master")
        run_command("git checkout -f -b master")
        run_command("git branch -d -r trunk")
      end
    end
    
    def optimize_repos
      run_command("git gc")
    end
    
    def run_command(cmd)
      log "Running command: #{cmd}"
      
      IO.popen(cmd) do |stdout|
        stdout.each do |line|
          log line
        end
      end
    end

    private
    
    def log(msg)
      puts msg if @options[:verbose]
    end

  end
end

