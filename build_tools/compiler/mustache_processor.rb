require 'erb'
require_relative 'template_processor'

module Compiler
  class MustacheProcessor < TemplateProcessor

    @@yield_hash = {
      after_header: "{{{ afterHeader }}}",
      body_classes: "{{ bodyClasses }}",
      body_end: "{{{ bodyEnd }}}",
      content: "{{{ content }}}",
      cookie_message: "{{{ cookieMessage }}}",
      footer_support_links: "{{{ footerSupportLinks }}}",
      footer_top: "{{{ footerTop }}}",
      head: "{{{ head }}}",
      header_class: "{{{ headerClass }}}",
      html_lang: "{{ htmlLang }}",
      inside_header: "{{{ insideHeader }}}",
      page_title: "{{ pageTitle }}",
      proposition_header: "{{{ propositionHeader }}}",
      top_of_page: "{{{ topOfPage }}}"
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
