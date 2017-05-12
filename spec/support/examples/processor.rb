require 'spec_helper'
require 'set'

shared_examples_for "a processor" do
  let(:html_erb_file) { "a/file.css" }
  let(:processor) { described_class.new(html_erb_file) }

  describe "convert rails tags into html" do

    let(:css_source)        { "govuk-template.css" }
    let(:js_source)         { "ie.js" }

    describe "#stylesheet_link_tag" do
      let(:css_options)     { {"media" => "print"} }
      let(:sri_attributes)  { {"integrity" => true, "crossorigin" => "anonymous"} }

      it "should parse the stylesheet tag" do
        expect(processor.stylesheet_link_tag(css_source)).to eql("<link rel=\"stylesheet\" media=\"screen\" href=\"#{processor.asset_path(css_source)}\"/>")
      end

      context "if css file is for print" do
        it "should parse the stylesheet tag and extra options" do
          expect(processor.stylesheet_link_tag(css_source, css_options)).to eql("<link rel=\"stylesheet\" media=\"print\" href=\"#{processor.asset_path(css_source)}\"/>")
        end
      end

      context "if sri attributes are present, it should ignore them" do
        it "should parse the stylesheet tag without the integrity attribute" do
          expect(processor.stylesheet_link_tag(css_source, sri_attributes)).to eql("<link rel=\"stylesheet\" media=\"screen\" href=\"#{processor.asset_path(css_source)}\"/>")
        end
      end
    end

    describe "#javascript_include_tag" do
      let(:js_options)      { {"charset" => "UTF-8"} }
      let(:sri_attributes)  { {"integrity" => true, "crossorigin" => "anonymous"} }

      it "should parse the javascript tag" do
        expect(processor.javascript_include_tag(js_source)).to eql("<script src=\"#{processor.asset_path(js_source)}\"></script>")
      end

      it "should parse the javascript tag and extra options" do
        expect(processor.javascript_include_tag(js_source, js_options)).to eql("<script src=\"#{processor.asset_path(js_source)}\" charset=\"UTF-8\"></script>")
      end

      it "if sri attributes are present, it should ignore them" do
        expect(processor.javascript_include_tag(js_source, sri_attributes)).to eql("<script src=\"#{processor.asset_path(js_source)}\"></script>")
      end
    end

    describe "#content_tag" do
      it "should return the correct html script tag" do
        expect(processor.content_tag(:script, " src=\"#{processor.asset_path(js_source)}\"")).to eql("<script src=\"#{processor.asset_path(js_source)}\"></script>")
      end
    end

    describe "#tag" do
      it "should return the correct html link tag" do
        expect(processor.tag(:link, " rel=\"stylesheet\" media=\"screen\" href=\"#{processor.asset_path(css_source)}\"")).to eql("<link rel=\"stylesheet\" media=\"screen\" href=\"#{processor.asset_path(css_source)}\"/>")
      end
    end

    describe "#tag_options" do
      let(:options) { {"rel"=>"stylesheet", "media"=>"screen", "href"=>processor.asset_path(css_source) } }

      it "flattens the hash into a string of quoted html attributes" do
        expect(processor.tag_options(options)).to eql(" rel=\"stylesheet\" media=\"screen\" href=\"#{processor.asset_path(css_source)}\"")
      end
    end

    describe "#exclude_sri_fields" do
      let(:options) { {"rel"=>"stylesheet", "media"=>"screen", "href"=>processor.asset_path(css_source), "integrity" => true, "crossorigin" => "anonymous" } }

      it "should remove the integrity and crossorigin keys from the hash" do
        expect(processor.exclude_sri_fields(options)).to eql({"href" => processor.asset_path(css_source), "media" => "screen", "rel" => "stylesheet"})
      end
    end

  end
end
