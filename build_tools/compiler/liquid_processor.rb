require 'erb'
require_relative 'template_processor'

module Compiler
  class LiquidProcessor < TemplateProcessor

    @@yield_hash = {
      after_header: "{% include layouts/_after_header.html %}",
      body_classes: "{% include layouts/_body_classes.html %}",
      body_end: "{% include layouts/_body.html %}",
      content: "{{ content }}",
      cookie_message: "{% include layouts/_cookie_message.html %}",
      footer_support_links: "{% include layouts/_footer_support_links.html %}",
      footer_top: "{% include layouts/_footer_top.html %}",
      head: "{% include layouts/_head.html %}",
      header_class: "{% if page.header_class %}{{ page.header_class }}{% endif %}",
      inside_header: "{% include layouts/_inside_header.html %}",
      page_title: "{% include layouts/_page_title.html %}",
      proposition_header: "{% include layouts/_proposition_header.html %}"
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
