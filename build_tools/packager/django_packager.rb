require 'open3'
require 'fileutils'
require 'idsk_template/version'
require_relative 'tar_packager'
require_relative '../compiler/django_processor'

module Packager
  class DjangoPackager < TarPackager
    def initialize
      super
      @base_name = "django_idsk_template-#{IdskTemplate::VERSION}"
    end

    def build
      @target_dir = @repo_root.join('pkg', @base_name)
      @target_dir.rmtree if @target_dir.exist?
      @target_dir.mkpath
      Dir.chdir(@target_dir) do |dir|
        prepare_contents
        parse_folders
        generate_package_files
        generate_setup_py
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

    def parse_folders
      package_dir = @target_dir.join('idsk_template')
      package_dir.mkpath
      File.rename @target_dir.join('assets'), package_dir.join('static')
      File.rename @target_dir.join('views'), package_dir.join('templates')
      File.rename package_dir.join('templates', 'layouts'), package_dir.join('templates', 'idsk_template')
    end

    def generate_setup_py
      template_abbreviation = "django"
      template_name = "Django"
      contents = ERB.new(File.read(File.join(@repo_root, "source/django/setup.py.erb"))).result(binding)
      File.open(File.join(@target_dir, "setup.py"), "w") do |f|
        f.write contents
      end
    end

    def generate_package_files
      files = [@repo_root.join("source/django", "MANIFEST.in"), @repo_root.join("LICENCE.txt")]
      files.each do |f|
        FileUtils.cp(f, @target_dir)
      end
      File.new(@target_dir.join("idsk_template", "__init__.py"), "w").close
    end

    def create_tarball
      Dir.chdir(@target_dir.join('..')) do
        @repo_root.join("pkg").mkpath
        target_file = @repo_root.join("pkg", "#{@base_name}.tgz").to_s
        output, status = Open3.capture2e("tar -czf #{target_file.shellescape} -C #{@base_name.shellescape} .")
        abort "Error creating tar:\n#{output}" if status.exitstatus > 0
      end
    end

  private

    def generated_file_name(file_path)
      if file_path.include? "idsk_template"
        "base.html"
      else
        File.basename(file_path, File.extname(file_path))
      end
    end
  end
end
