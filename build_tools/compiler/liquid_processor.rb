require 'erb'
require_relative 'template_processor'

module Compiler
  class LiquidProcessor < TemplateProcessor

    @@yield_hash = {
      page_title: "{% if page.title %}{{ page.title }}{% endif %}",
      head: "{% include layouts/_head.html %}",
      body_classes: "{% include layouts/_body_classes.html %}",
      content: "{{ content }}",
      body_end: "{% include layouts/_body.html %}",
      footer_top: "{% include layouts/_footer_top.html %}",
      footer_support_links: "{% include layouts/_footer_support_links.html %}",
      inside_header: "{% include layouts/_inside_header.html %}",
      after_header: "{% include layouts/_after_header.html %}",
      cookie_message: "{% include layouts/_cookie_message.html %}"
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
