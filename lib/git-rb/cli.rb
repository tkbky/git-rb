require 'thor'

module GitRb
  class Cli < Thor
    desc 'init', 'Create an empty Git repository or reinitialize an existing one'
    option :bare, type: :boolean
    def init
      GitRb::Api.init(options)
    end

    desc 'add <path>', 'Add file contents to the index'
    def add(path)
      GitRb::Api.add(path)
    end

    desc 'ls-files', 'Show information about files in the index and the working tree'
    def ls_files
      GitRb::Api.ls_files
    end
  end
end
