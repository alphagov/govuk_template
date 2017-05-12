require 'erb'
require 'active_support/core_ext/hash'
require 'active_support/core_ext/array'

module Compiler
  class TemplateProcessor
    def initialize(file)
      @file = file
      @is_stylesheet = !!(file =~ /\.css\.erb\z/)
    end

    def process
      # The block supplied to render_erb is invoked every time yield is called
      # in the template. This happens via the `binding`.
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
      raise "Not implemented on the base class"
    end

    def content_for?(*args)
      true
    end

    def asset_path(file, options={})
      raise "Not implemented on the base class"
    end

    def method_missing(name, *args)
      puts "#{name} #{args.inspect}"
    end

    def stylesheet_link_tag(*sources)
      options = sources.extract_options!.stringify_keys
      sources.uniq.map { |source|
        link_options = {
            "rel" => "stylesheet",
            "media" => "screen",
            "href" => asset_path(source)
        }.merge!(options)
        "<link#{tag_options(link_options)}/>"
      }.join("\n")
    end

    def javascript_include_tag(*sources)
      options = sources.extract_options!.stringify_keys
      sources.uniq.map { |source|
        script_options = {
            "src" => asset_path(source)
        }.merge!(options)
        "<script#{tag_options(script_options)}></script>"
      }.join("\n")
    end

  private
    def tag_options(options)
      return if options.empty?
      output = "".dup
      sep    = " "
      options.each_pair do |key, value|
        if !value.nil?
          output << sep
          output << %(#{key}="#{value}")
        end
      end
      output unless output.empty?
    end

  end
end
