
task :compile => "compile:all"

namespace :compile do
  def mainfests
    require 'yaml'
    @mainfests ||= YAML.load_file(File.expand_path('../manifests.yml', __FILE__))
  end

  task :all => [:javascripts, :stylesheets] do
  end

  task :javascripts do
    require 'sprockets'

    target_dir = File.expand_path('../build/assets/javascripts', __FILE__)
    FileUtils.mkdir_p(target_dir)

    env = Sprockets::Environment.new(File.expand_path('..', __FILE__))
    env.append_path "app/assets/javascripts"

    mainfests["javascripts"].each do |javascript|
      asset = env.find_asset(javascript)

      abort "Asset #{javascript} not found" unless asset
      File.open("#{target_dir}/#{javascript}.js", 'w') {|f| f.write asset.to_s }
    end
  end

  task :stylesheets do
    require 'sprockets'

    target_dir = File.expand_path('../build/assets/stylesheets', __FILE__)
    FileUtils.mkdir_p(target_dir)

    env = Sprockets::Environment.new(File.expand_path('..', __FILE__))
    env.append_path "app/assets/stylesheets"
    env.append_path File.join(Gem.loaded_specs["govuk_frontend_toolkit"].full_gem_path, 'app', 'assets', 'stylesheets')

    mainfests["stylesheets"].each do |stylesheet|
      asset = env.find_asset(stylesheet)

      abort "Asset #{stylesheet} not found" unless asset
      File.open("#{target_dir}/#{stylesheet}.css", 'w') {|f| f.write asset.to_s }
    end
  end
end
