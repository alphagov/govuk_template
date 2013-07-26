$:.unshift File.expand_path('../build_tools', __FILE__)

task :compile do
  require 'compiler/asset_compiler'
  Compiler::AssetCompiler.compile
end
