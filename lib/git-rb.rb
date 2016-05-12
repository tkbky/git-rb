# frozen_string_literal: true
require 'optparse'
require 'git-rb/version'
require 'git-rb/config'
require 'git-rb/repository'
require 'git-rb/api'
require 'git-rb/cli'

module GitRb

  ROOT_DIR = '.git'

  INDEX_PATH = "#{ROOT_DIR}/index"

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

end
