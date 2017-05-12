require 'spec_helper'
require 'set'

shared_examples_for "a processor" do
  let(:html_erb_file) { "a/file.css" }
  let(:processor) { described_class.new(html_erb_file) }

  describe "convert rails tags into html" do
    let(:css_source) { "govuk-template.css" }
    let(:js_source) { "ie.js" }

    describe "#stylesheet_link_tag" do
      let(:css_options) { { "media" => "print" } }

      it "writes out a link tag for the requested stylesheet" do
        expect(processor.stylesheet_link_tag(css_source)).to eql("<link rel=\"stylesheet\" media=\"screen\" href=\"#{processor.asset_path(css_source)}\"/>")
      end

      context "if css file is for print" do
        it "writes out a link tag for the requested stylesheet in the print media" do
          expect(processor.stylesheet_link_tag(css_source, css_options)).to eql("<link rel=\"stylesheet\" media=\"print\" href=\"#{processor.asset_path(css_source)}\"/>")
        end
      end
    end

    describe "#javascript_include_tag" do
      let(:js_options) { { "charset" => "UTF-8" } }

      it "writes out a script tag to include the requested javascript asset" do
        expect(processor.javascript_include_tag(js_source)).to eql("<script src=\"#{processor.asset_path(js_source)}\"></script>")
      end

      context "if charset is provided for the asset" do
        it "writes out a script tag to include the requested javascript asset in the charset" do
          expect(processor.javascript_include_tag(js_source, js_options)).to eql("<script src=\"#{processor.asset_path(js_source)}\" charset=\"UTF-8\"></script>")
        end
      end
    end
  end
end
