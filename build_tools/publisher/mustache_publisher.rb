require 'govuk_template/version'
require_relative '../helpers'
require 'tmpdir'
require 'open3'

module Publisher
  class MustachePublisher
    include Helpers
    GIT_URL = "https://#{ENV['GITHUB_TOKEN']}@github.com/alphagov/govuk_template_mustache.git"

    def initialize(version = GovukTemplate::VERSION)
      @version = version
      @repo_root = Pathname.new(File.expand_path('../../..', __FILE__))
      @source_dir = @repo_root.join('pkg', "mustache_govuk_template-#{@version}")
    end

    def publish
      Dir.mktmpdir("govuk_template_mustache") do |dir|
        run "git clone -q #{GIT_URL.shellescape} #{dir.shellescape}"
        Dir.chdir(dir) do
          run "ls -1 | grep -v 'README.md' | xargs -I {} rm -rf {}"
          run "cp -r #{@source_dir.to_s.shellescape}/* ."
          run "git add -A ."
          run "git commit -q -m 'Publishing GOV.UK {{ mustache }} template version #{@version}'"
          run "git tag v#{@version}"
          run "git push --tags origin master"
          run "npm publish ./"
        end
      end
    end
  end
end
