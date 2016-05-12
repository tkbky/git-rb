# frozen_string_literal: true
require 'fileutils'

module GitRb
  class Repository
    INIT_MSG = 'Initialized empty Git repository in'

    REINIT_MSG = 'Reinitialized existing Git repository in'

    ROOT_DIR = '.git'

    DOT_GIT_DIRS = [
      "hooks",
      "info",
      "objects/info",
      "objects/pack",
      "refs/heads",
      "refs/tags"
    ].freeze

    HOOK_INSTRUCTION = '# add shell script and make executable to enable'

    HOOK_FILES = [
      "hooks/applypatch-msg.sample",
      "hooks/commit-msg.sample",
      "hooks/post-update.sample",
      "hooks/pre-applypatch.sample",
      "hooks/pre-commit.sample",
      "hooks/pre-push.sample",
      "hooks/pre-rebase.sample",
      "hooks/prepare-commit-msg.sample",
      "hooks/update.sample"
    ].freeze

    DOT_GIT_FILES = [
      "HEAD",
      "config",
      "description",
      *HOOK_FILES
    ].freeze

    class << self
      def init(dir, config)
        @config = config
        init?(dir) ? do_reinit(dir) : do_init(dir)
      end

      private

      def init?(dir)
        Dir.exist?(File.join(dir, ROOT_DIR)) || DOT_GIT_DIRS.all? { |dir| Dir.exists?(dir) }
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
        FileUtils.mkdir_p(ROOT_DIR)
        FileUtils.cd(ROOT_DIR) do
          mk_dirs
          mk_files
        end
      end

      def do_reinit(dir)
        puts "#{REINIT_MSG} #{dir}"
        raise NotImplementedError
      end

      def mk_dirs
        DOT_GIT_DIRS.each { |dir| FileUtils.mkdir_p(dir) }
      end

      def mk_files
        DOT_GIT_FILES.each do |path, content|
          next if File.exist?(path)
          File.open(path, 'w') do |f|
            case path
            when /config/ then f.write(@config.to_s)
            when /hooks/ then f.write(HOOK_INSTRUCTION)
            end
          end
        end
      end
    end
  end
end
