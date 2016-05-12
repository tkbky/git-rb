# frozen_string_literal: true
require 'optparse'
require 'git-rb/version'
require 'git-rb/config'
require 'git-rb/repository'

module GitRb
  BANNER = <<-BANNER
Usage: git-rb [--version] <command> [<args>]

The most commonly used git commands are:
init      Create an empty Git repository or reinitialize an existing one


BANNER

  class << self
    def start(argv)
      options = {}

      options = OptionParser.new do |opts|
        opts.banner = BANNER
        print_version(opts)
        print_help(opts)
      end.parse!

      command = argv[0]
      execute(command)
    end

    def print_version(opts)
      opts.on(nil, '--version', 'Prints version') do
        puts "git version #{GitRb::VERSION}"
        exit
      end
    end

    def print_help(opts)
      opts.on('-h', '--help', 'Prints this help') do
        puts opts
        exit
      end
    end

    def execute(command)
      case command
      when 'init' then GitRb::Repository.init(Dir.pwd)
      else
        STDERR.puts('Unknown command')
        exit
      end
    end
  end

end
