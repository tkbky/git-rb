# frozen_string_literal: true
require 'digest/sha1'
require 'zlib'

module GitRb
  class Object
    DIR = 'objects'

    def content
      @content ||= File.read(@raw_path)
    end

    def deflated_content
      Zlib::Deflate.deflate(content)
    end

    def sha1
      @sha1 ||= Digest::SHA1.hexdigest(content)
    end
  end
end
