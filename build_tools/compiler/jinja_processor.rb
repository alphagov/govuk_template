require 'erb'
require_relative 'template_processor'

module Compiler
  class JinjaProcessor < TemplateProcessor

    def self.block_for(key)
      "{% block #{key} %}{% endblock %}"
    end

    @@yield_hash = {
      after_header:         block_for(:after_header),
      body_classes:         block_for(:body_classes),
      body_start:           block_for(:body_start),
      body_end:             block_for(:body_end),
      content:              block_for(:content),
      cookie_message:       block_for(:cookie_message),
      footer_support_links: block_for(:footer_support_links),
      footer_top:           block_for(:footer_top),
      homepage_url:         "{{ homepage_url|default('https://www.gov.uk/') }}",
      global_header_text:   "{{ global_header_text|default('GOV.UK') }}",
      head:                 block_for(:head),
      header_class:         block_for(:header_class),
      html_lang:            "{{ html_lang|default('en') }}",
      inside_header:        block_for(:inside_header),
      page_title:           "{% block page_title %}GOV.UK - The best place to find government services and information{% endblock %}",
      proposition_header:   block_for(:proposition_header),
      top_of_page:          block_for(:top_of_page),
    }

    def handle_yield(section = :layout)
      @@yield_hash[section]
    end

    def asset_path(file, options={})
      query_string = GovukTemplate::VERSION
      return "#{file}?#{query_string}" if @is_stylesheet
      case File.extname(file)
      when '.css'
        "{{ asset_path }}stylesheets/#{file}?#{query_string}"
      when '.js'
        "{{ asset_path }}javascripts/#{file}?#{query_string}"
      else
        "{{ asset_path }}images/#{file}?#{query_string}"
      end
    end
  end
end
