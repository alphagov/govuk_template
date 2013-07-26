require "bundler/gem_tasks"

$:.unshift File.expand_path('../build_tools', __FILE__)

task :build => :compile

task :compile do
  require 'compiler/asset_compiler'
  puts "Compiling assets into app/assets"
  Compiler::AssetCompiler.compile
end
