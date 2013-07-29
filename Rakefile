$:.unshift File.expand_path('../lib', __FILE__)
$:.unshift File.expand_path('../build_tools', __FILE__)
require "govuk_template/version"
require "gem_publisher"

desc "Compile assets from ./source into ./app/assets"
task :compile do
  require 'compiler/asset_compiler'
  puts "Compiling assets and templates into ./app"
  Compiler::AssetCompiler.compile
end

desc "Build both gem and tar version"
task :build => ["build:gem", "build:tar"]

namespace :build do
  desc "Build govuk_template-#{GovukTemplate::VERSION}.gem into the pkg directory"
  task :gem => :compile do
    puts "Building pkg/govuk_template-#{GovukTemplate::VERSION}.gem"
    gem = GemPublisher::Builder.new.build('govuk_template.gemspec')
    FileUtils.mv(gem, "pkg")
  end

  desc "Build govuk_template-#{GovukTemplate::VERSION}.tgz into the pkg directory"
  task :tar => :compile do
    puts "Building pkg/govuk_template-#{GovukTemplate::VERSION}.tar"
    require 'packager/tar_packager'
    Packager::TarPackager.build
  end

  desc "Release gem to gemfury if version has been updated"
  task :and_release_if_updated => :compile do
    if released_gem = GemPublisher.publish_if_updated('govuk_template.gemspec', :gemfury, :as => 'govuk')
      puts "Pushed #{released_gem}"
      # gem_publisher builds the gem in the root_dir
      FileUtils.mv(released_gem, "pkg")
      Rake::Task["build:tar"].invoke
    end
  end
end
