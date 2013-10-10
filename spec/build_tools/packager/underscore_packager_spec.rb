require 'spec_helper'
require File.join(PROJECT_ROOT, 'build_tools/compiler/asset_compiler.rb')
require File.join(PROJECT_ROOT, 'build_tools/packager/underscore_packager.rb')

describe Packager::UnderscorePackager do
  let(:generated_template_path) {File.join(PROJECT_ROOT, "pkg/underscore_govuk_template-#{GovukTemplate::VERSION}/views/layouts/govuk_template.html")}
  let(:generated_directory_path) {File.join(PROJECT_ROOT, "pkg/underscore_govuk_template-#{GovukTemplate::VERSION}")}
  let(:app_path) {File.join(PROJECT_ROOT, "app")}
  subject {described_class.new}

  after do
    FileUtils.rm_rf(generated_directory_path)
    FileUtils.rm_rf(app_path)
  end

  context "functional" do
    describe "build" do
      let(:example_template_path) {File.join(SPEC_ROOT, 'support/examples/underscore_govuk_template.html')}
      it "should output the correct template" do
        Compiler::AssetCompiler.compile
        subject.build( without_tarball = true )
        File.read(generated_template_path).should == File.read(example_template_path)
        #should test for all erb
        #should test for all copied
        #publish separately
      end
    end
  end

  #this is horrible because of pathname use
  context "#process_template" do
    let(:target_directory_path) {"/some/target/directory"}
    let(:pathname) {Pathname.new(target_directory_path)}
    let(:file_dir) {"a"}
    let(:file) {"file.html.erb"}
    let(:non_erb_file) {"file.html"}
    let(:file_path) {"#{file_dir}/#{file}"}
    let(:mock_file) {double(:file)}
    let(:mock_processor) {double(:processor)}
    let(:file_contents_result) {"<h1>hello there!</h1>"}

    let(:target_dir) {double(:target_dir)}
    let(:target_file_path) {double(:target_file_path)}
    before do
      subject.instance_variable_set(:@target_dir, pathname)
    end
    it "should make a directory, compile a template for underscore and write it the correct location in the directory" do
      pathname.should_receive(:join).with(file_dir).ordered.and_return target_dir
      target_dir.should_receive(:mkpath).ordered
      target_dir.should_receive(:join).with(non_erb_file).ordered.and_return target_file_path
      File.should_receive(:open).with(target_file_path, "wb").ordered.and_yield mock_file
      Compiler::UnderscoreProcessor.should_receive(:new).with(file_path).and_return mock_processor
      mock_processor.should_receive(:process).and_return file_contents_result
      mock_file.should_receive(:write).with file_contents_result
      subject.process_template(file_path)
    end
  end
  #bleugh

end
