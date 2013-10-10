require 'spec_helper'
require File.join(PROJECT_ROOT, 'build_tools/packager/underscore_packager.rb')

describe Packager::UnderscorePackager do
  let(:generated_template_path) {File.join(PROJECT_ROOT, "pkg/underscore_govuk_template-#{GovukTemplate::VERSION}/views/layouts/govuk_template.html")}
  let(:generated_directory_path) {File.join(PROJECT_ROOT, "pkg/underscore_govuk_template-#{GovukTemplate::VERSION}")}
  subject {described_class.new}

  after do
    FileUtils.rm_rf(generated_directory_path)
  end

  context "functional" do
    let(:example_template_path) {File.join(SPEC_ROOT, 'support/examples/underscore_govuk_template.html')}
    it "should output the correct template" do
      subject.build( without_tarball = true )
      File.read(generated_template_path).should == File.read(example_template_path)
    end
  end

end
