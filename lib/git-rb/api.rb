# frozen_string_literal: true
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

      def rm(path, opts = {})
        paths_to_remove = GitRb::Index.new.match(path)

        raise IOError, "#{path} did not match any files" if paths_to_remove.blank?

        raise IOError, "not removing #{path} recursively without -r" if File.directory?(path) && !opts[:r]

        # TODO:
        # Do not remove if the file
        # 1. has been staged
        # 2. has been changed since last commit

        if File.directory?(path)
          FileUtils.rm_rf(path)
        else
          File.delete(path)
        end

        GitRb::Index.new.remove(paths_to_remove)
      end

      def ls_files
        puts GitRb::Index.new.content
      end
    end
  end
end
