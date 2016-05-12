require 'git-rb/blob'
require 'git-rb/index'

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
        File.open(blob.object_path, 'w') { |f| f.write(blob.deflated_content) }
        GitRb::Index.new.add(blob)
      end

      def ls_files
        puts GitRb::Index.new.content
      end

    end
  end
end
