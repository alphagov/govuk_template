require 'erb'

module Compiler
  class TemplateProcessor

    def initialize(file)
      @file = file
      @is_stylesheet = !!(file =~ /\.css\.erb\z/)
    end

    def process
      render_erb do |section = :layout|
        handle_yield(section)
      end
    end

    def render_erb
      ERB.new(File.read(@file)).result(binding)
    end

    def handle_yield(section = :layout)
      if section == :layout
        "<!-- Page content goes here -->"
      end
    end

    def content_for?(*args)
      false
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
