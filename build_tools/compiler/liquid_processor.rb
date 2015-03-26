require 'erb'
require_relative 'template_processor'

module Compiler
  class LiquidProcessor < TemplateProcessor

    @@yield_hash = {
      after_header: "{% include layouts/_after_header.html %}",
      body_classes: "{% include layouts/_body_classes.html %}",
      body_start: "{% include layouts/_body_start.html %}",
      body_end: "{% include layouts/_body.html %}",
      content: "{{ content }}",
      cookie_message: "{% include layouts/_cookie_message.html %}",
      footer_support_links: "{% include layouts/_footer_support_links.html %}",
      footer_top: "{% include layouts/_footer_top.html %}",
      head: "{% include layouts/_head.html %}",
      header_class: "{% if page.header_class %}{{ page.header_class }}{% endif %}",
      html_lang: "{% if page.html_lang %}{{ page.html_lang }}{% else %}en{% endif %}",
      inside_header: "{% include layouts/_inside_header.html %}",
      page_title: "{% include layouts/_page_title.html %}",
      proposition_header: "{% include layouts/_proposition_header.html %}",
      skip_link_message: "{% if page.skip_link_message %}{{ page.skip_link_message }}{% else %}Skip to main content{% endif %}",
      logo_link_title: "{% if page.logo_link_title %}{{ page.logo_link_title }}{% else %}Go to the GOV.UK homepage{% endif %}",
      licence_message: "{% include layouts/_licence_message.html %}",
      crown_copyright_message: "{% if page.crown_copyright_message %}{{ page.crown_copyright_message }}{% else %}&copy; Crown copyright{% endif %}"
    }

    def handle_yield(section = :layout)
      @@yield_hash[section]
    end

    def asset_path(file, options={})
      return file if @is_stylesheet
      case File.extname(file)
      when '.css'
        "{{ site.govuk_template_assets }}/stylesheets/#{file}"
      when '.js'
        "{{ site.govuk_template_assets }}/javascripts/#{file}"
      else
        "{{ site.govuk_template_assets }}/images/#{file}"
      end
    end

    def content_for?(*args)
      @@yield_hash.include? args[0]
    end
  end
end
