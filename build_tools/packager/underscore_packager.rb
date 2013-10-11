require 'open3'
require 'govuk_template/version'
require_relative 'tar_packager'
require_relative '../compiler/underscore_processor'

module Packager
  class UnderscorePackager < TarPackager
    def initialize
      super
      @base_name = "underscore_govuk_template-#{GovukTemplate::VERSION}"
    end

    def build( without_package = false )
      @target_dir = @repo_root.join('pkg', @base_name)
      @target_dir.rmtree if @target_dir.exist?
      @target_dir.mkpath
      Dir.chdir(@target_dir) do |dir|
        prepare_contents
        create_package unless without_package
      end
    end

    def create_package

    end

    def process_template(file)
      target_dir = @target_dir.join(File.dirname(file))
      target_dir.mkpath
      File.open(target_dir.join(generated_file_name(file)), 'wb') do |f|
        f.write Compiler::UnderscoreProcessor.new(file).process
      end
    end

    private

    def generated_file_name(file_path)
      File.basename(file_path, File.extname(file_path))
    end
  end
end
