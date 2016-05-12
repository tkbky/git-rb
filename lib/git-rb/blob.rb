require 'git-rb/object'

module GitRb
  class Blob < Object

    def initialize(path)
      @path = path
    end

    def directory
      File.join(GitRb::ROOT_DIR, GitRb::Object::DIR, sha1[0..1])
    end

    def path
      File.join(directory, sha1[2..-1])
    end

    def type
      :blob
    end

  end
end
