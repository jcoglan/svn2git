module Svn2Git
  class Migration
  
    attr_reader :dir
    
    def initialize(url, options = {})
      @url = url
      @dir = @url.scan(/[^\/]+/).last
      @run = "cd #{@dir} &&"
      
      @options = options
      @options[:trunk] ||= 'trunk'
      @options[:branches] ||= 'branches'
      @options[:tags] ||= 'tags'
    end
    
    def run!
      clone!
      fix_tags
      fix_branches
      fix_trunk
    end
    
  private
    
    def clone!
      trunk = @options[:trunk]
      branches = @options[:branches]
      tags = @options[:tags]
      puts `git svn clone --no-metadata --trunk=#{trunk} --branches=#{branches} --tags=#{tags} #{@url}`
      get_branches
    end
    
    def get_branches
      @branches = `#{@run} git branch -a`.split(/\n/)
      @local = `#{@run} git branch`.split(/\n/)
      @remote = @branches.find_all { |b| not @local.include?(b) }
      @tags = @remote.find_all { |b| b.strip =~ /^tags\// }
    end
    
    def fix_tags
      @tags.each do |tag|
        id = tag.scan(/[\d\.]+/).first
        `#{@run} git checkout #{tag}`
        `#{@run} git tag -a -m "Tagging release #{id}" #{id}`
      end
    end
    
    def fix_branches
      svn_branches = @remote.find_all { |b| not @tags.include?(b) }
      svn_branches.each do |branch|
        branch = branch.strip
        next if branch == @options[:trunk]
        `#{@run} git checkout #{branch}`
        `#{@run} git checkout -b #{branch}`
      end
    end
    
    def fix_trunk
      trunk = @remote.find { |b| b.strip == @options[:trunk] }
      if trunk
        `#{@run} git branch -D master`
        `#{@run} git checkout trunk`
        `#{@run} git checkout -f -b master`
      end
    end
  
  end
end

