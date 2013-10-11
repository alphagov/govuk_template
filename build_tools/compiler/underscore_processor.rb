require 'erb'
require_relative 'template_processor'

module Compiler
  class UnderscoreProcessor < TemplateProcessor
    
    @@yield_hash = {
      page_title: "<%= pageTitle %>",
      head: "<%= head %>",
      body_classes: "<%= bodyClasses %>",
      content: "<%= content %>",
      body_end: "<%= bodyEnd %>",
      top_of_page: "<%= topOfPage %>",
      footer_top: "<%= footerTop %>",
      footer_support_links: "<%= footerSupportLinks %>",
      inside_header: "<%= insideHeader %>",
      cookie_message: "<%= cookieMessage %>"
    }

    def render_erb
      f=File.read(@file) 
      #why @@-ms-viewport, not @ms-viewport?
      f.gsub!(/@-ms-viewport/, "@@-ms-viewport") unless @is_stylesheet
      ERB.new(f).result(binding)
    end
    
    def handle_yield(section = :layout)
      @@yield_hash[section]
      #omit header and inside header?
      #show cookie message?
    end

    def asset_path(file, options={})
      return file if @is_stylesheet
      case File.extname(file)
      when '.css'
        "<%= assetPath %>stylesheets/#{file}"
      when '.js'
        "<%= assetPath %>javascripts/#{file}"
      else
        "<%= assetPath %>images/#{file}"
      end
    end

    def content_for?(*args)
      @@yield_hash.include? args[0]
    end
  end
end
