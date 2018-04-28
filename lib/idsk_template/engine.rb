module IdskTemplate
  class Engine < ::Rails::Engine
    initializer "idsk_template.assets.precompile" do |app|
      app.config.assets.precompile += %w(
        favicon.ico
        idsk-template*.css
        fonts*.css
        idsk-template.js
        ie.js
        apple-touch-icon-180x180.png
        apple-touch-icon-167x167.png
        apple-touch-icon-152x152.png
        apple-touch-icon.png
        gov.uk_logotype_crown_invert.png
        gov.uk_logotype_crown_invert_trans.png
        gov.uk_logotype_crown.svg
        opengraph-image.png
      )
    end
  end
end
