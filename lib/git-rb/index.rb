# frozen_string_literal: true
require 'singleton'

module GitRb
  class Index
    attr_reader :content

    def initialize(path)
      @path = path
      p @path
      File.open(path, 'w') {} unless File.exist?(path)
      @content = File.read(path) || ''
    end

    def add(blob)
      # Actual git index can be found here: https://www.kernel.org/pub/software/scm/git/docs/technical/index-format.txt
      # Simple entry format for git index
      # <raw-path> <sha1> <object-path>
      if paths.include?(blob.sha1)
        puts "Entry for #{blob.raw_path} has already indexed"
      else
        File.open(@path, 'a') { |f| f.puts("#{blob.raw_path} #{blob.sha1} #{blob.object_path}") }
      end
    end

    def remove(path)
      @content = entries.reject! { |entry| entry[0] =~ /^#{path}/ }.join("\n")
    end

    def match(path)
      raw_paths.select { |raw_path| raw_path =~ /^#{path}/ }
    end

    def entries
      @content.split(/\n/).map { |entry| entry.split(/\s/) }
    end

    def raw_paths
      entries[0]
    end

    def sha1s
      entries[1]
    end

    def object_paths
      entries[2]
    end
  end
end
