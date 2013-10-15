require 'spec_helper'
require File.join(PROJECT_ROOT, 'build_tools/compiler/asset_compiler.rb')
require File.join(PROJECT_ROOT, 'build_tools/packager/mustache_packager.rb')

describe Packager::MustachePackager do
  let(:generated_directory_path) {File.join(PROJECT_ROOT, "pkg/mustache_govuk_template-#{GovukTemplate::VERSION}")}
  let(:generated_template_path) {File.join(generated_directory_path, "views/layouts/govuk_template.html")}
  let(:generated_package_json_path) {File.join(generated_directory_path, "package.json")}
  subject {described_class.new}

  after do
    FileUtils.rm_rf(generated_directory_path)
  end

  context "functional" do
    describe "build" do

      let(:example_template_path) {File.join(SPEC_ROOT, 'support/examples/mustache_govuk_template.html')}
      let(:example_package_json) {ERB.new(File.read(File.join(SPEC_ROOT, 'support/examples/package.json'))).result(binding)}
      it "should output the correct template" do
        subject.build
        File.read(generated_template_path).should == File.read(example_template_path)
        File.read(generated_package_json_path).should == example_package_json
      end

    end
  end

end
