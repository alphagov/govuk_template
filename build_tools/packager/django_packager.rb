require 'open3'
require 'govuk_template/version'
require_relative 'tar_packager'
require_relative '../compiler/django_processor'

module Packager
  class DjangoPackager < TarPackager
    def initialize
      super
      @base_name = "django_govuk_template-#{GovukTemplate::VERSION}"
    end

    def build
      @target_dir = @repo_root.join('pkg', @base_name)
      @target_dir.rmtree if @target_dir.exist?
      @target_dir.mkpath
      Dir.chdir(@target_dir) do |dir|
        prepare_contents
        create_tarball
      end
    end

    def process_template(file)
      target_dir = @target_dir.join(File.dirname(file))
      target_dir.mkpath
      File.open(target_dir.join(generated_file_name(file)), 'wb') do |f|
        f.write Compiler::DjangoProcessor.new(file).process
      end
    end

    private

    def generated_file_name(file_path)
      if file_path.include? "govuk_template"
        "base.html"
      else
        File.basename(file_path, File.extname(file_path))
      end
    end
  end
end
