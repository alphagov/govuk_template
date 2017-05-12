require 'spec_helper'
require 'set'

shared_examples_for "a processor" do
  let(:html_erb_file) {"a/file.css"}
  let(:processor) { described_class.new(html_erb_file) }

  describe "convert rails tags into html" do

    let(:css_source)        { "govuk-template.css" }
    let(:js_source)         { "ie.js" }

    describe "#stylesheet_link_tag" do
      let(:css_options)       { {"media" => "print"} }

      it "should parse the stylesheet tag" do
        expect(processor.stylesheet_link_tag(css_source)).to eql("<link rel=\"stylesheet\" media=\"screen\" href=\"#{processor.asset_path(css_source)}\"/>")
      end

      context "if css file is for print" do
        it "should parse the stylesheet tag for print" do
          expect(processor.stylesheet_link_tag(css_source, css_options)).to eql("<link rel=\"stylesheet\" media=\"print\" href=\"#{processor.asset_path(css_source)}\"/>")
        end
      end
    end

    describe "#javascript_include_tag" do
      let(:js_options)        { {"charset" => "UTF-8"} }

      it "should parse the javascript tag" do
        expect(processor.javascript_include_tag(js_source)).to eql("<script src=\"#{processor.asset_path(js_source)}\"></script>")
      end

      it "should parse the javascript tag" do
        expect(processor.javascript_include_tag(js_source, js_options)).to eql("<script src=\"#{processor.asset_path(js_source)}\" charset=\"UTF-8\"></script>")
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

    describe "#extract_options!" do
      let(:options) { ["govuk-template.css", {"media" => "print"}]}

      it "should extract the last part of the options" do
        expect(processor.extract_options!(options)).to eql({"media" => "print"})
      end
    end

    describe "#stringify_keys" do
      let(:options) { {:media => "print"} }

      it "should turn keys of a hash into strings" do
        expect(processor.stringify_keys(options)).to eql({"media"=>"print"})
      end
    end

    describe "#tag_options" do
      let(:options) { {"rel"=>"stylesheet", "media"=>"screen", "href"=>processor.asset_path(css_source)} }

      it "should parse the hash" do
        expect(processor.tag_options(options)).to eql(" rel=\"stylesheet\" media=\"screen\" href=\"#{processor.asset_path(css_source)}\"")
      end
    end

  end
end
