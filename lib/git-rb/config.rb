module GitRb
  class Config
    CORE = {
      repository_format_version: 0,
      filemode: true,
      bare: false,
      local_ref_updates: true,
      ignore_case: true,
      precompose_unicode: true,
    }.freeze

    CORE_STR = <<-CORE
[core]
#{CORE.map { |k, v| "\s\s#{k} = #{v}" }.join("\n")}
CORE

    attr_accessor *CORE.keys

    def initialize(opts = {})
      opts ||= {}
      CORE.each { |k, v| self.instance_variable_set("@#{k}", opts[k] || v) }
    end

    def to_s
<<-CONFIG
#{CORE_STR}
CONFIG
    end
  end
end
