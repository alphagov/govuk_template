require 'erb'
require_relative 'template_processor'

module Compiler
  class EJSProcessor < TemplateProcessor

    @@yield_hash = {
      after_header: "<%- partial('partials/_after_header') %>",
      body_classes: "<%- partial('partials/_body_classes') %>",
      body_end: "<%- partial('partials/_body_end') %>",
      content: "<%= content %>",
      cookie_message: "<%- partial('partials/_cookie_message') %>",
      footer_support_links: "<%- partial('partials/_footer_support_links') %>",
      footer_top: "<%- partial('partials/_footer_top') %>",
      head: "<%- partial('partials/_head') %>",
      header_class: "<% if page.header_class { %><%= header_class %><% } else { %>en<% } %>",
      html_lang: "<% if page.html_lang { %><%= html_lang %><% } else { %>en<% } %>",
      inside_header: "<%- partial('partials/_inside_header') %>",
      page_title: "<%- partial('partials/_page_title') %>",
      proposition_header: "<%- partial('partials/_proposition_header') %>",
      top_of_page: "<%- partial('partials/_top_of_page') %>",
    }

    def handle_yield(section = :layout)
      @@yield_hash[section]
    end

    def asset_path(file, options={})
      query_string = GovukTemplate::VERSION
      return "#{file}?#{query_string}" if @is_stylesheet
      case File.extname(file)
      when '.css'
        "<%= govuk_template_asset_path %>stylesheets/#{file}?#{query_string}"
      when '.js'
        "<%= govuk_template_asset_path %>javascripts/#{file}?#{query_string}"
      else
        "<%= govuk_template_asset_path %>images/#{file}?#{query_string}"
      end
    end

    def content_for?(*args)
      @@yield_hash.include? args[0]
    end
  end
end
