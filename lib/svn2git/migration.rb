module Svn2Git
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
      `git svn init --no-metadata --trunk=#{trunk} --branches=#{branches} --tags=#{tags} #{@url}`
      `git config svn.authorsfile #{@authors}` if @authors
      `git svn fetch`
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
        `git checkout #{tag}`
        `git tag -a -m "Tagging release #{id}" #{id}`
      end
    end
    
    def fix_branches
      svn_branches = @remote.find_all { |b| not @tags.include?(b) }
      svn_branches.each do |branch|
        branch = branch.strip
        next if branch == @options[:trunk]
        `git checkout #{branch}`
        `git checkout -b #{branch}`
      end
    end
    
    def fix_trunk
      trunk = @remote.find { |b| b.strip == @options[:trunk] }
      if trunk
        `git branch -D master`
        `git checkout trunk`
        `git checkout -f -b master`
      end
    end
  
  end
end

