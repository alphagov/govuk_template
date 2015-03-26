require 'erb'
require_relative 'template_processor'

module Compiler
  class JinjaProcessor < TemplateProcessor

    @@yield_hash = {
      after_header: "{% block after_header %}{% endblock %}",
      body_classes: "{% block body_classes %}{% endblock %}",
      body_start: "{% block body_start %}{% endblock %}",
      body_end: "{% block body_end %}{% endblock %}",
      content: "{% block content %}{% endblock %}",
      cookie_message: "{% block cookie_message %}{% endblock %}",
      footer_support_links: "{% block footer_support_links %}{% endblock %}",
      footer_top: "{% block footer_top %}{% endblock %}",
      head: "{% block head %}{% endblock %}",
      header_class: "{% block header_class %}{% endblock %}",
      html_lang: "{{ html_lang|default('en') }}",
      inside_header: "{% block inside_header %}{% endblock %}",
      page_title: "{% block page_title %}GOV.UK - The best place to find government services and information{% endblock %}",
      proposition_header: "{% block proposition_header %}{% endblock %}",
      top_of_page: "{% block top_of_page %}{% endblock %}",
      skip_link_message: "{{ skip_link_message|default('Skip to main content') }}",
      logo_link_title: "{{ logo_link_title|default('Go to the GOV.UK homepage') }}",
      licence_message: "{% block licence_message %}<p>All content is available under the <a href=\"https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/\" rel=\"license\">Open Government Licence v3.0</a>, except where otherwise stated</p>{% endblock %}",
      crown_copyright_message: "{{ crown_copyright_message|default('&copy; Crown copyright') }}"
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

    def content_for?(*args)
      @@yield_hash.include? args[0]
    end
  end
end
