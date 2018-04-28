require 'spec_helper'
require File.join(PROJECT_ROOT, 'build_tools/compiler/asset_compiler.rb')
require File.join(PROJECT_ROOT, 'build_tools/packager/django_packager.rb')

describe Packager::DjangoPackager do
  let(:generated_directory_path) {File.join(PROJECT_ROOT, "pkg/django_idsk_template-#{IdskTemplate::VERSION}")}
  let(:generated_template_path) {File.join(generated_directory_path, "idsk_template/templates/idsk_template/base.html")}
  subject {described_class.new}

  after do
    FileUtils.rm_rf(generated_directory_path)
  end

  context "functional" do
    describe "build" do

      it "should output the correct template" do
        subject.build

        generated_template = File.read(generated_template_path)
        expect(generated_template).to match(%r[\A{% load staticfiles %}{% block top_of_page %}{% endblock %}])
        expect(generated_template).to match(%r[href="{% static 'stylesheets/idsk-template\.css' %}"])
      end

    end
  end

end
