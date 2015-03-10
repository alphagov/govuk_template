require 'open3'
require 'govuk_template/version'
require 'packager/tar_packager'
require 'compiler/razor_processor'
require 'govuk_frontend_toolkit/version'

module Packager
  class RazorPackager < TarPackager
    def initialize
      super
      @base_name = "razor_govuk_template-#{GovukTemplate::VERSION}"
    end

    def build
      @target_dir = @repo_root.join('pkg', @base_name)
      @target_dir.rmtree if @target_dir.exist?
      @target_dir.mkpath
      Dir.chdir(@target_dir) do |dir|
        generate_package_nuspec
        prepare_contents
        create_tarball
      end
    end

    def generate_package_nuspec
      contents = ERB.new(File.read(File.join(@repo_root, "source/GovUK.Template.Razor.nuspec.erb"))).result(binding)
      File.open(File.join(@target_dir, "GovUK.Template.Razor.nuspec"), "w") do |f|
        f.write contents
      end
    end

    def process_template(file)
      target_dir = @target_dir.join(File.dirname(file))
      target_dir.mkpath
      target_file = File.basename(file, File.extname(file)).sub(/\.html\z/, '.cshtml') # /path/to/foo.html.erb -> foo.cshtml
      File.open(target_dir.join(target_file), 'wb') do |f|
        f.write Compiler::RazorProcessor.new(file).process
      end
    end

    def prepare_contents
      super
      run "mono #{@repo_root}/tools/nuget.exe pack GovUK.Template.Razor.nuspec -Version #{GovukTemplate::VERSION}"
      FileUtils.mv("GovUK.Template.Razor.#{GovukTemplate::VERSION}.nupkg", @repo_root.join('pkg'))
    end

    def run(command)
      output, status = Open3.capture2e(command)
      abort "Error running #{command}: exit #{status.exitstatus}\n#{output}" if status.exitstatus > 0
      output
    end
  end
end
