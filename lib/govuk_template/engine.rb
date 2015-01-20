module GovukTemplate
  class Engine < ::Rails::Engine
    initializer "govuk_template.assets.precompile" do |app|
      app.config.assets.precompile += %w(
        govuk-template*.css
        fonts*.css
        govuk-template.js
        ie-8.js
        ie-mobile-10.js
        ie.js
        js-enabled.js
        vendor/goog/webfont-debug.js
      )
    end
  end
end
