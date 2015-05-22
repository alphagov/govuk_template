require 'erb'
require_relative 'template_processor'

module Compiler
  class JinjaProcessor < TemplateProcessor

    def self.block_for(key, default_value="")
      "{% block #{key} %}#{default_value}{% endblock %}"
    end

    def self.statement_tag_for(key, default_value)
      "{{ #{key}|default('#{default_value}') }}"
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
      homepage_url:         statement_tag_for(:homepage_url, 'https://www.gov.uk'),
      global_header_text:   statement_tag_for(:global_header_text, 'GOV.UK'),
      head:                 block_for(:head),
      header_class:         block_for(:header_class),
      html_lang:            statement_tag_for(:html_lang, 'en'),
      inside_header:        block_for(:inside_header),
      page_title:           block_for(:page_title, "GOV.UK - The best place to find government services and information"),
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
