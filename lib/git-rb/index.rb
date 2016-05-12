require 'singleton'

module GitRb
  class Index
    attr_reader :content

    def initialize
      File.open(GitRb::INDEX_PATH, 'w') {} unless File.exist?(GitRb::INDEX_PATH)
      @content = File.read(GitRb::INDEX_PATH) || ''
    end

    def add(blob)
      # Actual git index can be found here: https://www.kernel.org/pub/software/scm/git/docs/technical/index-format.txt
      # Simple entry format for git index
      # <raw-path> <sha1> <object-path>
      if @content.split(/\n/).map { |entry| entry.split(/\s/)[1] }.include?(blob.sha1)
        puts "Entry for #{blob.raw_path} has already indexed"
      else
        File.open(GitRb::INDEX_PATH, 'a') { |f| f.puts("#{blob.raw_path} #{blob.sha1} #{blob.object_path}") }
      end
    end

  end
end
