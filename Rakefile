require "bundler/gem_tasks"

$:.unshift File.expand_path('../lib', __FILE__)
$:.unshift File.expand_path('../build_tools', __FILE__)
require "govuk_template/version"

task :build => :compile

desc "Compile assets from ./source into ./app/assets"
task :compile do
  require 'compiler/asset_compiler'
  puts "Compiling assets into app/assets"
  Compiler::AssetCompiler.compile
end

namespace :build do
  desc "Build govuk_template-#{GovukTemplate::VERSION}.tgz into the pkg directory"
  task :tar => :compile do
    require 'packager/tar_packager'
    Packager::TarPackager.build
  end
end
