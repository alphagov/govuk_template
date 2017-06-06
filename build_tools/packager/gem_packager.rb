module Packager
  class GemPackager
    def self.build
      new.build
    end

    def initialize
      @repo_root = Pathname.new(File.expand_path('../../..', __FILE__))
    end

    def build
      Dir.chdir @repo_root do
        stdout_str = run('gem build govuk_template.gemspec')
        gem = stdout_str[/File:\s+(.+)/, 1]

        @repo_root.join('pkg').mkpath
        FileUtils.mv(gem, "pkg")
      end
    end

  private

    def run(command)
      output, status = Open3.capture2e(command)
      abort "Error running #{command}: exit #{status.exitstatus}\n#{output}" if status.exitstatus > 0
      output
    end    
  end
end
