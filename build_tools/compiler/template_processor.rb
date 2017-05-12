require 'erb'

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
      options = stringify_keys(extract_options!(sources))
      sources.uniq.map { |source|
        link_options = {
            "rel" => "stylesheet",
            "media" => "screen",
            "href" => asset_path(source)
        }.merge!(options)
        tag(:link, tag_options(link_options))
      }.join("\n")
    end

    def javascript_include_tag(*sources)
      options = stringify_keys(extract_options!(sources))
      sources.uniq.map { |source|
        script_options = {
            "src" => asset_path(source)
        }.merge!(options)
        content_tag(:script, tag_options(script_options))
      }.join("\n")
    end

    def content_tag(name, options = nil)
      "<#{name}#{options}></#{name}>"
    end

    def tag(name, options)
      "<#{name}#{options}/>"
    end

    def extract_options!(options)
      if options.last.is_a?(Hash) && extractable_options?(options.last)
        options.pop
      else
        {}
      end
    end

    def extractable_options?(options)
      options.instance_of?(Hash)
    end

    def stringify_keys(options)
      result = {}
      options.each_key do |key|
        result[key.to_s] = options[key]
      end
      result
    end

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
