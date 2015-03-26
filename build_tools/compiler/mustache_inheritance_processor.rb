require 'erb'
require_relative 'template_processor'

module Compiler
  class MustacheInheritanceProcessor < TemplateProcessor

    @@yield_hash = {
      after_header: "{{$afterHeader}}{{/afterHeader}}",
      body_classes: "{{$bodyClasses}}{{/bodyClasses}}",
      body_start: "{{$bodyStart}}{{/bodyStart}}",
      body_end: "{{$bodyEnd}}{{/bodyEnd}}",
      content: "{{$content}}{{/content}}",
      cookie_message: "{{$cookieMessage}}{{/cookieMessage}}",
      footer_support_links: "{{$footerSupportLinks}}{{/footerSupportLinks}}",
      footer_top: "{{$footerTop}}{{/footerTop}}",
      head: "{{$head}}{{/head}}",
      header_class: "{{$headerClass}}{{/headerClass}}",
      html_lang: "{{$htmlLang}}en{{/htmlLang}}",
      inside_header: "{{$insideHeader}}{{/insideHeader}}",
      page_title: "{{$pageTitle}}GOV.UK - The best place to find government services and information{{/pageTitle}}",
      proposition_header: "{{$propositionHeader}}{{/propositionHeader}}",
      skip_link_message: "{{$skipLinkMessage}}Skip to main content{{/skipLinkMessage}}",
      logo_link_title: "{{$logoLinkTitle}}Go to the GOV.UK homepage{{/logoLinkTitle}}",
      licence_message: "{{$licenceMessage}}<p>All content is available under the <a href=\"https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/\" rel=\"license\">Open Government Licence v3.0</a>, except where otherwise stated</p>{{/licenceMessage}}",
      crown_copyright_message: "{{$crownCopyrightMessage}}&copy; Crown copyright{{/crownCopyrightMessage}}"
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

    def content_for?(*args)
      @@yield_hash.include? args[0]
    end
  end
end
