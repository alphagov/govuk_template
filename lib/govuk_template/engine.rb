module GovukTemplate
  class Engine < ::Rails::Engine
    initializer "govuk_template.assets.precompile" do |app|
      app.config.assets.precompile += %w(
        favicon.ico
        govuk-template*.css
        fonts*.css
        govuk-template.js
        ie.js
        apple-touch-icon-120x120.png
        apple-touch-icon-152x152.png
        apple-touch-icon-60x60.png
        apple-touch-icon-76x76.png
        gov.uk_logotype_crown_invert.png
        gov.uk_logotype_crown_invert_trans.png
        opengraph-image.png
      )
    end
  end
end
