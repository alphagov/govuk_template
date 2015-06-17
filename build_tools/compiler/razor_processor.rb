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
        '@Html.Raw(ViewBag.HtmlLang ?? "en")'
      when :page_title
        '@Html.Raw(ViewBag.Title ?? "GOV.UK - The best place to find government services and information")'
      when :top_of_page
        render_section_for(:top_of_page)
      when :head
        render_section_for(:head)
      when :body_classes
        "@Html.Raw(ViewBag.BodyClasses ?? string.Empty)"
      when :body_start
        render_section_for(:body_start)
      when :cookie_message
        '@Html.Raw(ViewBag.CookieMessage ?? "<p>GOV.UK uses cookies to make the site simpler. <a href=\"https://www.gov.uk/help/cookies\">Find out more about cookies</a></p>")'
      when :header_class
        "@Html.Raw(ViewBag.HeaderClass ?? string.Empty)"
      when :homepage_url
        '@Html.Raw(ViewBag.HomepageUrl ?? "https://www.gov.uk/")'
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
      when :skip_link_message
        '@Html.Raw(ViewBag.SkipLinkMessage ?? "Skip to main content")'
      when :logo_link_title
        '@Html.Raw(ViewBag.LogoLinkTitle ?? "Go to the GOV.UK homepage")'
      when :global_header_text
        '@Html.Raw(ViewBag.GlobalHeaderText ?? "GOV.UK")'
      when :licence_message
        '@Html.Raw(ViewBag.LicenceMessage ?? "<p>All content is available under the <a href=\"https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/\" rel=\"license\">Open Government Licence v3.0</a>, except where otherwise stated</p>")'
      when :crown_copyright_message
        '@Html.Raw(ViewBag.CrownCopyrightMessage ?? "&copy; Crown copyright")'
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
