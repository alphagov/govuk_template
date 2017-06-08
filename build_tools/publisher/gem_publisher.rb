require 'govuk_template/version'
require_relative '../helpers'
require 'tmpdir'
require 'open3'

module Publisher
  class GemPublisher
    include Helpers

    GIT_REPO = "github.com/alphagov/govuk_template.git"
    GIT_URL = "https://#{ENV['GITHUB_TOKEN']}@#{GIT_REPO}"

    def initialize(version = GovukTemplate::VERSION)
      @version = version
    end

    def publish
      puts "Pushing govuk_template-#{GovukTemplate::VERSION}"
      run "gem push pkg/govuk_template-#{GovukTemplate::VERSION}.gem"
      Dir.mktmpdir("govuk_template_gem") do |dir|
        run("git clone -q #{GIT_URL.shellescape} #{dir.shellescape}",
            "Error running `git clone` on #{GIT_REPO}")
        Dir.chdir(dir) do
          run "git tag v#{@version}"
          run "git push --tags origin master"
        end
      end
    end
  end
end
