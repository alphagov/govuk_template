$:.unshift File.expand_path('../lib', __FILE__)
$:.unshift File.expand_path('../build_tools', __FILE__)
require "govuk_template/version"
require "gem_publisher"

desc "Compile template and assets from ./source into ./app"
task :compile do
  require 'compiler/asset_compiler'
  puts "Compiling assets and templates into ./app"
  Compiler::AssetCompiler.compile
end

desc "Build both gem and tar version"
task :build => ["build:gem", "build:tar", "build:play", "build:mustache"]

namespace :build do
  desc "Build govuk_template-#{GovukTemplate::VERSION}.gem into the pkg directory"
  task :gem => :compile do
    puts "Building pkg/govuk_template-#{GovukTemplate::VERSION}.gem"
    require 'packager/gem_packager'
    Packager::GemPackager.build
  end

  desc "Build govuk_template-#{GovukTemplate::VERSION}.tgz into the pkg directory"
  task :tar => :compile do
    puts "Building pkg/govuk_template-#{GovukTemplate::VERSION}.tgz"
    require 'packager/tar_packager'
    Packager::TarPackager.build
  end

  desc "Build play_govuk_template-#{GovukTemplate::VERSION}.tgz into the pkg directory"
  task :play => :compile do
    puts "Building pkg/play_govuk_template-#{GovukTemplate::VERSION}.tgz"
    require 'packager/play_packager'
    Packager::PlayPackager.build
  end

  desc "Build mustache_govuk_template-#{GovukTemplate::VERSION} into the pkg directory"
  task :mustache => :compile do
    puts "Building pkg/mustache_govuk_template-#{GovukTemplate::VERSION}"
    require 'packager/mustache_packager'
    Packager::MustachePackager.build
  end

  desc "Build and release to github if version has been updated"
  task :mustache_and_release_if_updated => :"build:mustache" do
    require 'publisher/mustache_publisher'
    q = Publisher::MustachePublisher.new
    if q.version_released?
      puts "govuk_template_mustache #{GovukTemplate::VERSION} already released. Not pushing."
    else
      puts "Pushing govuk_template_mustache #{GovukTemplate::VERSION} to git repo"
      q.publish
    end
  end

  desc "Build and release gem to gemfury if version has been updated"
  task :and_release_if_updated => :build do
    p = GemPublisher::Publisher.new('govuk_template.gemspec')
    if p.version_released?
      puts "govuk_template-#{GovukTemplate::VERSION} already released.  Not pushing."
    else
      puts "Pushing govuk_template-#{GovukTemplate::VERSION} to gemfury"
      p.pusher.push "pkg/govuk_template-#{GovukTemplate::VERSION}.gem", :gemfury, :as => 'govuk'
      p.git_remote.add_tag "v#{GovukTemplate::VERSION}"
      puts "Done."
    end

    require 'publisher/play_publisher'
    q = Publisher::PlayPublisher.new
    if q.version_released?
      puts "govuk_template_play #{GovukTemplate::VERSION} already released. Not pushing."
    else
      puts "Pushing govuk_template_play #{GovukTemplate::VERSION} to git repo"
      q.publish
    end
  end
end

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task :spec => :compile
task :default => :spec
