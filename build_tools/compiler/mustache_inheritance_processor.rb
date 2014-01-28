require 'erb'
require_relative 'template_processor'

module Compiler
  class MustacheInheritanceProcessor < TemplateProcessor

    @@yield_hash = {
      page_title: "{{$pageTitle}}GOV.UK - The best place to find government services and information{{/pageTitle}}",
      head: "{{$head}}{{/head}}",
      body_classes: "{{$bodyClasses}}{{/bodyClasses}}",
      content: "{{$content}}{{/content}}",
      body_end: "{{$bodyEnd}}{{/bodyEnd}}",
      footer_top: "{{$footerTop}}{{/footerTop}}",
      footer_support_links: "{{$footerSupportLinks}}{{/footerSupportLinks}}",
      inside_header: "{{$insideHeader}}{{/insideHeader}}",
      after_header: "{{$afterHeader}}{{/afterHeader}}",
      cookie_message: "{{$cookieMessage}}{{/cookieMessage}}",
      header_class: "{{$headerClass}}{{/headerClass}}",
      proposition_header: "{{$propositionHeader}}{{/propositionHeader}}"
    }

    def handle_yield(section = :layout)
      @@yield_hash[section]
    end

    def asset_path(file, options={})
      return file if @is_stylesheet
      case File.extname(file)
      when '.css'
        "{{assetPath}}stylesheets/#{file}"
      when '.js'
        "{{assetPath}}javascripts/#{file}"
      else
        "{{assetPath}}images/#{file}"
      end
    end

    def content_for?(*args)
      @@yield_hash.include? args[0]
    end
  end
end
