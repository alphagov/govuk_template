require 'erb'
require_relative 'template_processor'

module Compiler
  class MustacheInheritanceProcessor < TemplateProcessor

    def self.tag_for(lowerCamelCaseKey)
      "{{$#{lowerCamelCaseKey}}}{{/#{lowerCamelCaseKey}}}"
    end

    @@yield_hash = {
      after_header:         tag_for(:afterHeader),
      body_classes:         tag_for(:bodyClasses),
      body_start:           tag_for(:bodyStart),
      body_end:             tag_for(:bodyEnd),
      content:              tag_for(:content),
      cookie_message:       tag_for(:cookieMessage),
      footer_support_links: tag_for(:footerSupportLinks),
      footer_top:           tag_for(:footerTop),
      head:                 tag_for(:head),
      header_class:         tag_for(:headerClass),
      html_lang:            "{{$htmlLang}}en{{/htmlLang}}",
      inside_header:        tag_for(:insideHeader),
      page_title:           "{{$pageTitle}}GOV.UK - The best place to find government services and information{{/pageTitle}}",
      proposition_header:   tag_for(:propositionHeader),
      top_of_page:          tag_for(:topOfPage),
    }

    def handle_yield(section = :layout)
      @@yield_hash[section]
    end

    def asset_path(file, options={})
      return file if @is_stylesheet
      case File.extname(file)
      when '.css'
        "{{{ assetPath }}}stylesheets/#{file}"
      when '.js'
        "{{{ assetPath }}}javascripts/#{file}"
      else
        "{{{ assetPath }}}images/#{file}"
      end
    end
  end
end
