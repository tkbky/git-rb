# frozen_string_literal: true
require 'fileutils'

module GitRb
  class Repository
    INIT_MSG = 'Initialized empty Git repository in'

    REINIT_MSG = 'Reinitialized existing Git repository in'

    class << self
      def init(dir, config)
        @config = config
        init?(dir) ? do_reinit(dir) : do_init(dir)
      end

      private

      def init?(dir)
        Dir.exist?(File.join(dir, GitRb::ROOT_DIR)) || GitRb::DOT_GIT_DIRS.all? { |dir| Dir.exist?(dir) }
      end

      def do_init(dir)
        puts "#{INIT_MSG} #{dir}"
        @config.bare ? init_bare : init_common
      end

      def init_bare
        mk_dirs
        mk_files
      end

      def init_common
        FileUtils.mkdir_p(GitRb::ROOT_DIR)
        FileUtils.cd(GitRb::ROOT_DIR) do
          mk_dirs
          mk_files
        end
      end

      def do_reinit(dir)
        puts "#{REINIT_MSG} #{dir}"
        raise NotImplementedError
      end

      def mk_dirs
        GitRb::DOT_GIT_DIRS.each { |dir| FileUtils.mkdir_p(dir) }
      end

      def mk_files
        DOT_GIT_FILES.each do |path, _content|
          next if File.exist?(path)
          File.open(path, 'w') do |f|
            case path
            when /config/ then f.write(@config.to_s)
            when /hooks/ then f.write(GitRb::HOOK_INSTRUCTION)
            end
          end
        end
      end
    end
  end
end
