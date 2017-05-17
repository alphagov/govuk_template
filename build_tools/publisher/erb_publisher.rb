require 'govuk_template/version'
require 'tmpdir'
require 'open3'

module Publisher
  class ErbPublisher
    attr_accessor :version

    GIT_URL = "https://#{ENV['GITHUB_TOKEN']}@github.com/alphagov/govuk_template.git"

    def initialize(version = GovukTemplate::VERSION)
      @version = version
    end

    def publish
      puts "Pushing govuk_template-#{GovukTemplate::VERSION}"
      run "gem push pkg/govuk_template-#{GovukTemplate::VERSION}.gem"
      Dir.mktmpdir("govuk_template_erb") do |dir|
        run "git clone -q #{GIT_URL.shellescape} #{dir.shellescape}"
        Dir.chdir(dir) do
          run "git tag v#{@version}"
          run "git push --tags origin master"
        end
      end
    end

    def version_released?
      output = run "git ls-remote --tags #{GIT_URL.shellescape}"
      return !! output.match(/v#{@version}/)
    end

    private

    def run(command)
      output, status = Open3.capture2e(command)
      abort "Error running #{command}: exit #{status.exitstatus}\n#{output}" if status.exitstatus > 0
      output
    end
  end
end
