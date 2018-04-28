require 'idsk_template/version'
require_relative '../helpers'
require 'tmpdir'
require 'open3'

module Publisher
  class EJSPublisher
    include Helpers
    GIT_REPO = "github.com/id-sk/idsk_template_ejs.git"
    GIT_URL = "https://#{ENV['GITHUB_TOKEN']}@#{GIT_REPO}"

    def initialize(version = IdskTemplate::VERSION)
      @version = version
      @repo_root = Pathname.new(File.expand_path('../../..', __FILE__))
      @source_dir = @repo_root.join('pkg', "ejs_idsk_template-#{@version}")
    end

    def publish
      Dir.mktmpdir("idsk_template_ejs") do |dir|
        run("git clone -q #{GIT_URL.shellescape} #{dir.shellescape}",
            "Error running `git clone` on #{GIT_REPO}")
        Dir.chdir(dir) do
          run "ls -1 | grep -v 'README.md' | xargs -I {} rm -rf {}"
          run "cp -r #{@source_dir.to_s.shellescape}/* ."
          run "git add -A ."
          run "git commit -q -m 'Publishing ID-SK Embedded JavaScript template version #{@version}'"
          run "git tag v#{@version}"
          run "git push --tags origin master"
          run "npm publish ./"
        end
      end
    end

    def version_released?
      output = run("git ls-remote --tags #{GIT_URL.shellescape}")
      return !! output.match(/v#{@version}/)
    end
  end
end
