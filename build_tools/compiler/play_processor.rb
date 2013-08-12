require 'erb'

module Compiler
  class PlayProcessor

    def initialize(file)
      @file = file
      @is_stylesheet = !!(file =~ /\.css\.erb\z/)
    end

    def process
      render_erb do |section = :layout|
        handle_yield(section)
      end
    end

    def raw html 
      html
    end 

    def render_erb
      ERB.new(File.read(@file)).result(binding)
    end

    def handle_yield(section = :layout)
      case section
      when :layout
        "<!-- Page content goes here -->"
      when :page_title
        "GOV.UK - @title.getOrElse('The best place to find government services and information)"
      when :top_of_page
        "@(title: Option[String], bodyClasses: Option[String])(head:Html, bodyEnd:Html)(content:Html)"
      when :head
        "@head"
      when :body_classes
        "@bodyClasses.getOrElse(\'\')"
      when :content
        "@content"
      when :body_end
        "@bodyEnd"
      else 
        ""
      end
    end

    def content_for?(*args)
      [:page_title, :content, :head, :body_classes, :body_end, :top_of_page].include? args[0]
    end

    def asset_path(file, optons={})
      return file if @is_stylesheet
      case File.extname(file)
      when '.css'
        "/assets/stylesheets/#{file}"
      when '.js'
        "/assets/javascripts/#{file}"
      else
        "/assets/images/#{file}"
      end
    end

    def method_missing(name, *args)
      puts "#{name} #{args.inspect}"
    end
  end
end
