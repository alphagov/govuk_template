require 'idsk_template/version'
require_relative '../helpers'
require 'tmpdir'
require 'open3'

module Publisher
  class GemPublisher
    include Helpers

    GIT_REPO = "github.com/id-sk/idsk_template.git"
    GIT_URL = "https://#{ENV['GITHUB_TOKEN']}@#{GIT_REPO}"

    def initialize(version = IdskTemplate::VERSION)
      @version = version
    end

    def publish
      puts "Pushing idsk_template-#{IdskTemplate::VERSION}"
      run "gem push pkg/idsk_template-#{IdskTemplate::VERSION}.gem"
      Dir.mktmpdir("idsk_template_gem") do |dir|
        run("git clone -q #{GIT_URL.shellescape} #{dir.shellescape}",
            "Error running `git clone` on #{GIT_REPO}")
        Dir.chdir(dir) do
          run "git tag v#{@version}"
          run "git push --tags origin master"
        end
      end
    end

    def version_released?
      output = run("git ls-remote --tags #{GIT_URL.shellescape}")
      return !! output.match(/v#{@version}/)
    end
  end
end
