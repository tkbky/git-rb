require 'git-rb/version'
require 'optparse'

module GitRb
  def self.start(argv)
    options = {}

    options = OptionParser.new do |opts|
      opts.banner = """
Usage: git-rb [--version] <command> [<args>]

The most commonly used git commands are:
  init      Create an empty Git repository or reinitialize an existing one


"""
      opts.on(nil, '--version', 'Prints version') do
        puts "git version #{GitRb::VERSION}"
        exit
      end

      opts.on('-h', '--help', 'Prints this help') do
        puts opts
        exit
      end
    end.parse!
  end
end
