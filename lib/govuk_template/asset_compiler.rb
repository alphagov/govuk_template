require 'yaml'
require 'open3'
require 'sprockets'

module GovukTemplate
  class AssetCompiler
    def self.compile
      new.compile
    end

    def initialize
      @repo_root = Pathname.new(File.expand_path('../../..', __FILE__))
      @build_dir = @repo_root.join('build', 'assets')

      @manifests = YAML.load_file(@repo_root.join('manifests.yml'))
    end

    attr_reader :manifests

    def compile
      prepare_build_dir
      compile_javascripts
      compile_stylesheets
      copy_static_assets
    end

    def compile_javascripts
      env = Sprockets::Environment.new(@repo_root)
      env.append_path "app/assets/javascripts"

      manifests["javascripts"].each do |javascript|
        asset = env.find_asset(javascript)

        abort "Asset #{javascript} not found" unless asset
        File.open(@build_dir.join('javascripts', "#{javascript}.js"), 'w') {|f| f.write asset.to_s }
      end
    end

    def compile_stylesheets
      env = Sprockets::Environment.new(@repo_root)
      env.append_path "app/assets/stylesheets"
      env.append_path File.join(Gem.loaded_specs["govuk_frontend_toolkit"].full_gem_path, 'app', 'assets', 'stylesheets')

      manifests["stylesheets"].each do |stylesheet|
        asset = env.find_asset(stylesheet)

        abort "Asset #{stylesheet} not found" unless asset
        File.open(@build_dir.join('stylesheets', "#{stylesheet}.css"), 'w') {|f| f.write asset.to_s }
      end
    end

    def copy_static_assets
      excluded_extensions = %w(.js .css .scss)

      Dir.chdir @repo_root.join("app", "assets") do
        files = []
        Dir.glob("**/*") do |file|
          next if File.directory?(file)
          next if excluded_extensions.include?(File.extname(file))
          files << file
        end

        output, status = Open3.capture2e("cp -r --parents #{files.shelljoin} #{@build_dir.to_s.shellescape}")
        abort "Error copying files:\n#{output}" if status.exitstatus > 0
      end
    end

    private

    def prepare_build_dir
      @build_dir.rmtree
      @build_dir.mkpath
      @build_dir.join('stylesheets').mkpath
      @build_dir.join('javascripts').mkpath
    end
  end
end
