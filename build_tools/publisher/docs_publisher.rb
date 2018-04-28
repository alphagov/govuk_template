require 'idsk_template/version'
require_relative '../helpers'
require 'tmpdir'
require 'open3'
require 'mustache'
require 'yaml'

module Publisher
  class DocsPublisher
    include Helpers
    GIT_REPO = "github.com/id-sk/idsk_template.git"
    GIT_URL = "https://#{ENV['GITHUB_TOKEN']}@#{GIT_REPO}"

    def initialize(version = IdskTemplate::VERSION)
      @version = version
      @repo_root = Pathname.new(File.expand_path('../../..', __FILE__))
      @pkg_dir = @repo_root.join('pkg')
      @mustache_dir = @pkg_dir.join("mustache_idsk_template-#{@version}")
    end

    def publish
      Dir.mktmpdir("idsk_template_docs") do |dir|
        run("git clone -q #{GIT_URL.shellescape} #{dir.shellescape} --branch gh-pages",
            "Error running `git clone` on #{GIT_REPO}")
        Dir.chdir(dir) do
          # Remove old assets
          FileUtils.rm_r("assets", force: true)

          # Copy assets folder to current path
          FileUtils.cp_r("#{@mustache_dir}/assets", "./")

          # Load mustache template
          mustache_template = File.read("#{@mustache_dir}/views/layouts/idsk_template.html")

          # Loop over all stub data files
          Dir['data/*.yml'].each do |data_file_path|
            base = File.basename(data_file_path, '.yml')

            # Load data file and render mustache with that data
            mustache_data = YAML.load(File.read(data_file_path))
            template = Mustache.render(mustache_template, mustache_data)
            template = template.gsub('VERSION_NAME', @version)

            # Save the rendered file
            File.open("#{base}.html", "w") do |file|
              file.write(template)
            end
          end

          run "git add -A ."
          run "git commit -q -m 'Publishing idsk_template examples version #{@version}'"
          run "git push origin gh-pages"
        end
      end
    end
  end
end
