require 'erb'
require 'compiler/template_processor'

module Compiler
  class PlayProcessor < TemplateProcessor

    def render_erb
      f=File.read(@file)
      f.gsub!(/@-ms-viewport/, "@@-ms-viewport") unless @is_stylesheet
      ERB.new(f).result(binding)
    end

    def handle_yield(section = :layout)
      case section
      when :layout
        "<!-- Page content goes here -->"
      when :page_title
        "@title.getOrElse(\"GOV.UK - The best place to find government services and information\")"
      when :top_of_page
        "@(title: Option[String], bodyClasses: Option[String])(head:Html, bodyEnd:Html, insideHeader:Html, afterHeader:Html, footerTop:Html, footerLinks:Html)(content:Html)"
      when :head
        "@head"
      when :body_classes
        "@bodyClasses.getOrElse(\"\")"
      when :header_class
        "@header_class"
      when :propositional_header
        "@proposition_header"
      when :content
        "@content"
      when :body_end
        "@bodyEnd"
      when :inside_header
        "@insideHeader"
      when :after_header
        "@afterHeader"
      when :footer_top
        "@footerTop"
      when :footer_support_links
        "@footerLinks"
      else
        ""
      end
    end

    def asset_path(file, options={})
      return file if @is_stylesheet
      case File.extname(file)
      when '.css'
        "@routes.Template.at(\"stylesheets/#{file}\")"
      when '.js'
        "@routes.Template.at(\"javascripts/#{file}\")"
      else
        "@routes.Template.at(\"images/#{file}\")"
      end
    end

    def content_for?(*args)
      [:page_title, :content, :head, :body_classes, :body_end, :top_of_page, :inside_header, :after_header, :footer_top, :footer_support_links].include? args[0]
    end
  end
end
