require 'erb'
require 'compiler/template_processor'

module Compiler
  class RazorProcessor < TemplateProcessor

    def render_erb
      f=File.read(@file)
      f.gsub!(/@-ms-viewport/, "@@-ms-viewport") unless @is_stylesheet
      ERB.new(f).result(binding)
    end

    def handle_yield(section = :layout)
      case section
      when :layout
        "<!-- Page content goes here -->"
      when :html_lang
        "@(ViewBag.HtmlLang ?? \"en\")"
      when :page_title
        "@(ViewBag.Title ?? \"GOV.UK - The best place to find government services and information\")"
      when :top_of_page
        "@RenderSection(\"top_of_page\", required: false)"
      when :head
		"@RenderSection(\"head\", required: false)"
      when :body_classes
        "@(ViewBag.BodyClasses ?? string.Empty)"
      when :header_class
        "@(ViewBag.HeaderClass ?? string.Empty)"
      when :proposition_header
		"@RenderSection(\"proposition_header\", required: false)"
      when :content
        "@RenderBody()"
      when :body_end
		"@RenderSection(\"body_end\", required: false)"
      when :inside_header
		"@RenderSection(\"inside_header\", required: false)"
      when :after_header
		"@RenderSection(\"after_header\", required: false)"
      when :footer_top
		"@RenderSection(\"footer_top\", required: false)"
      when :footer_support_links
		"@RenderSection(\"footer_support_links\", required: false)"
      else
        ""
      end
    end

    def asset_path(file, options={})
      return file if @is_stylesheet
      case File.extname(file)
      when '.css'
        "@Url.Content(\"~/Content/govuk/stylesheets/#{file}\")"
      when '.js'
        "@Url.Content(\"~/Scripts/govuk/#{file}\")"
      else
        "@Url.Content(\"~/Content/govuk/images/#{file}\")"
      end
    end

    def content_for?(*args)
      [:layout, :page_title, :content, :head, :body_classes, :body_end,
        :top_of_page, :inside_header, :after_header, :footer_top,
        :footer_support_links, :html_lang, :header_class, :propositional_header
      ].include? args[0]
    end
  end
end
