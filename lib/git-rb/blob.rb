# frozen_string_literal: true
require 'git-rb/object'

module GitRb
  class Blob < Object
    attr_reader :raw_path

    def initialize(raw_path)
      @raw_path = raw_path
    end

    def directory
      File.join(GitRb::ROOT_DIR, GitRb::Object::DIR, sha1[0..1])
    end

    def object_path
      File.join(directory, sha1[2..-1])
    end

    def type
      :blob
    end
  end
end
