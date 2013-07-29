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
    require 'packager/gem_packager'
    Packager::GemPackager.build
  end

  desc "Build govuk_template-#{GovukTemplate::VERSION}.tgz into the pkg directory"
  task :tar => :compile do
    puts "Building pkg/govuk_template-#{GovukTemplate::VERSION}.tar"
    require 'packager/tar_packager'
    Packager::TarPackager.build
  end

  desc "Release gem to gemfury if version has been updated"
  task :and_release_if_updated => :compile do
    p = GemPublisher::Publisher.new('govuk_template.gemspec')
    if p.version_released?
      puts "govuk_template-#{GovukTemplate::VERSION} already released."
    else
      Rake::Task["build:gem"].invoke
      Rake::Task["build:tar"].invoke
      p.pusher.push "pkg/govuk_template-#{GovukTemplate::VERSION}.gem", :gemfury, :as => 'govuk'
      p.git_remote.add_tag "v#{GovukTemplate::VERSION}"
    end
  end
end
