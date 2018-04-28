require_relative '../helpers'

module Packager
  class GemPackager
    include Helpers

    def self.build
      new.build
    end

    def initialize
      @repo_root = Pathname.new(File.expand_path('../../..', __FILE__))
    end

    def build
      Dir.chdir @repo_root do
        stdout_str = run('gem build idsk_template.gemspec')
        gem = stdout_str[/File:\s+(.+)/, 1]

        @repo_root.join('pkg').mkpath
        FileUtils.mv(gem, "pkg")
      end
    end
  end
end
