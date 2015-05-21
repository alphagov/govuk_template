require 'erb'
require_relative 'template_processor'

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
        '@(ViewBag.HtmlLang ?? "en")'
      when :page_title
        '@(ViewBag.Title ?? "GOV.UK - The best place to find government services and information")'
      when :top_of_page
        render_section_for(:top_of_page)
      when :head
        render_section_for(:head)
      when :body_classes
        "@(ViewBag.BodyClasses ?? string.Empty)"
      when :body_start
        render_section_for(:body_start)
      when :cookie_message
        '@(ViewBag.CookieMessage ?? "<p>GOV.UK uses cookies to make the site simpler. <a href=\"https://www.gov.uk/help/cookies\">Find out more about cookies</a></p>")'
      when :header_class
        "@(ViewBag.HeaderClass ?? string.Empty)"
      when :homepage_url
        '@(ViewBag.HomepageUrl ?? "https://www.gov.uk/")'
      when :proposition_header
        render_section_for(:proposition_header)
      when :content
        "@RenderBody()"
      when :body_end
        render_section_for(:body_end)
      when :inside_header
        render_section_for(:inside_header)
      when :after_header
        render_section_for(:after_header)
      when :footer_top
        render_section_for(:footer_top)
      when :footer_support_links
        render_section_for(:footer_support_links)
      else
        raise "Unexpected section: #{section.inspect}"
      end
    end

    def render_section_for(label)
      %Q{@RenderSection("#{label}", required: false)}
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
  end
end
