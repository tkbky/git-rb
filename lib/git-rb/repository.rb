# frozen_string_literal: true
require 'fileutils'

module GitRb
  class Repository
    INIT_MSG = 'Initialized empty Git repository in'

    REINIT_MSG = 'Reinitialized existing Git repository in'

    ROOT_DIR = '.git'

    DOT_GIT_DIRS = [
      "#{ROOT_DIR}/hooks",
      "#{ROOT_DIR}/info",
      "#{ROOT_DIR}/objects/info",
      "#{ROOT_DIR}/objects/pack",
      "#{ROOT_DIR}/refs/heads",
      "#{ROOT_DIR}/refs/tags"
    ].freeze

    HOOK_INSTRUCTION = '# add shell script and make executable to enable'

    DOT_GIT_FILES = {
      "#{ROOT_DIR}/HEAD" => '',
      "#{ROOT_DIR}/config" => '',
      "#{ROOT_DIR}/description" => '',
      "#{ROOT_DIR}/hooks/applypatch-msg.sample" => HOOK_INSTRUCTION,
      "#{ROOT_DIR}/hooks/commit-msg.sample" => HOOK_INSTRUCTION,
      "#{ROOT_DIR}/hooks/post-update.sample" => HOOK_INSTRUCTION,
      "#{ROOT_DIR}/hooks/pre-applypatch.sample" => HOOK_INSTRUCTION,
      "#{ROOT_DIR}/hooks/pre-commit.sample" => HOOK_INSTRUCTION,
      "#{ROOT_DIR}/hooks/pre-push.sample" => HOOK_INSTRUCTION,
      "#{ROOT_DIR}/hooks/pre-rebase.sample" => HOOK_INSTRUCTION,
      "#{ROOT_DIR}/hooks/prepare-commit-msg.sample" => HOOK_INSTRUCTION,
      "#{ROOT_DIR}/hooks/update.sample" => HOOK_INSTRUCTION
    }.freeze

    class << self
      def init(dir, _opts = {})
        init?(dir) ? do_reinit(dir) : do_init(dir)
      end

      private

      def init?(dir)
        Dir.exist?(File.join(dir, ROOT_DIR))
      end

      def do_init(dir)
        puts "#{INIT_MSG} #{dir}"
        mk_dirs
        mk_files
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
          File.open(path, 'w') { |f| f.write(content) }
        end
      end
    end
  end
end
