require 'git-rb/blob'

module GitRb
  class Api
    class << self

      def init(opts = {})
        GitRb::Repository.init(Dir.pwd, Config.new(bare: opts[:bare]))
      end

      ##
      # add a file
      # 1. create a new blob file in .git/objects
      # 2. add file to index in .git/index
      def add(path)
        blob = GitRb::Blob.new(path)
        FileUtils.mkdir_p(blob.directory)
        File.open(blob.path, 'w') { |f| f.write(blob.deflated_content) }
        File.open(GitRb::INDEX_PATH, 'a') { |f| f.puts("#{blob.sha1} #{blob.path}") }
      end

    end
  end
end
