require 'spec_helper'
require File.join(PROJECT_ROOT, 'build_tools/compiler/asset_compiler.rb')
require File.join(PROJECT_ROOT, 'build_tools/packager/ejs_packager.rb')

describe Packager::EJSPackager do
  let(:generated_directory_path) {File.join(PROJECT_ROOT, "pkg/ejs_govuk_template-#{GovukTemplate::VERSION}")}
  let(:generated_template_path) {File.join(generated_directory_path, "views/layouts/govuk_template.html")}
  let(:generated_package_json_path) {File.join(generated_directory_path, "package.json")}
  subject {described_class.new}

  after do
    FileUtils.rm_rf(generated_directory_path)
  end

  context "functional" do
    describe "build" do

      let(:example_package_json) {ERB.new(File.read(File.join(SPEC_ROOT, 'support/examples/package_ejs.json'))).result(binding)}
      it "should output the correct template" do
        subject.build

        generated_template = File.read(generated_template_path)
        generated_template.should =~ %r[href="<%= govuk_template_asset_path %>stylesheets/govuk-template\.css\?#{Regexp.escape(GovukTemplate::VERSION)}"]

        File.read(generated_package_json_path).should == example_package_json
      end

    end
  end

end
