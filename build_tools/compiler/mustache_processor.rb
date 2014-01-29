require 'erb'
require_relative 'template_processor'

module Compiler
  class MustacheProcessor < TemplateProcessor

    @@yield_hash = {
      page_title: "{{ pageTitle }}",
      head: "{{{ head }}}",
      body_classes: "{{ bodyClasses }}",
      content: "{{{ content }}}",
      body_end: "{{{ bodyEnd }}}",
      top_of_page: "{{{ topOfPage }}}",
      footer_top: "{{{ footerTop }}}",
      footer_support_links: "{{{ footerSupportLinks }}}",
      inside_header: "{{{ insideHeader }}}",
      header_class: "{{{ headerClass }}}",
      proposition_header: "{{{ propositionHeader }}}",
      after_header: "{{{ afterHeader }}}",
      cookie_message: "{{{ cookieMessage }}}"
    }

    def handle_yield(section = :layout)
      @@yield_hash[section]
    end

    def asset_path(file, options={})
      query_string = GovukTemplate::VERSION
      return "#{file}?#{query_string}" if @is_stylesheet
      case File.extname(file)
      when '.css'
        "{{ assetPath }}stylesheets/#{file}?#{query_string}"
      when '.js'
        "{{ assetPath }}javascripts/#{file}?#{query_string}"
      else
        "{{ assetPath }}images/#{file}?#{query_string}"
      end
    end

    def content_for?(*args)
      @@yield_hash.include? args[0]
    end
  end
end
