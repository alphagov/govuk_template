require 'open3'
require 'govuk_template/version'
require_relative 'tar_packager'
require_relative '../compiler/mustache_inheritance_processor'

module Packager
  class MustacheInheritancePackager < TarPackager
    def initialize
      super
      @base_name = "mustache_inheritance_govuk_template-#{GovukTemplate::VERSION}"
    end

    def build
      @target_dir = @repo_root.join('pkg', @base_name)
      @target_dir.rmtree if @target_dir.exist?
      @target_dir.mkpath
      Dir.chdir(@target_dir) do |dir|
        generate_package_json
        prepare_contents
        create_tarball
      end
    end

    def generate_package_json
      template_abbreviation = "mustache_inheritance"
      template_name = "{{ mustache }}"
      contents = ERB.new(File.read(File.join(@repo_root, "source/package.json.erb"))).result(binding)
      File.open(File.join(@target_dir, "package.json"), "w") do |f|
        f.write contents
      end
    end

    def process_template(file)
      target_dir = @target_dir.join(File.dirname(file))
      target_dir.mkpath
      target_file = File.basename(file, File.extname(file)).sub(/\.html\z/, '.mustache')
      File.open(target_dir.join(target_file), 'wb') do |f|
        f.write Compiler::MustacheInheritanceProcessor.new(file).process
      end
    end
  end
end
