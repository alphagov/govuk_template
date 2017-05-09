require 'govuk_template/version'
require 'tmpdir'
require 'open3'
require "gem_publisher"

module Publisher
  class ErbPublisher
    attr_accessor :version

    GIT_URL = "https://#{ENV['GITHUB_TOKEN']}@github.com/alphagov/govuk_template.git"

    def initialize(version = GovukTemplate::VERSION)
      @version = version
      @p = GemPublisher::Publisher.new('govuk_template.gemspec')
    end

    def publish
      puts "Pushing govuk_template-#{GovukTemplate::VERSION}"
      @p.pusher.push "pkg/govuk_template-#{GovukTemplate::VERSION}.gem", :rubygems
      Dir.mktmpdir("govuk_template_erb") do |dir|
        run "git clone -q #{GIT_URL.shellescape} #{dir.shellescape}"
        Dir.chdir(dir) do
          run "git tag v#{@version}"
          run "git push --tags origin master"
        end
      end
    end

    def version_released?
      @p.version_released?
    end

    private

    def run(command)
      output, status = Open3.capture2e(command)
      abort "Error running #{command}: exit #{status.exitstatus}\n#{output}" if status.exitstatus > 0
      output
    end
  end
end
