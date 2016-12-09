# 0.19.2

- Increase skiplink colour contrast ([PR #263](https://github.com/alphagov/govuk_template/pull/263))
- Fix Scala compile issues for Play template ([PR #261](https://github.com/alphagov/govuk_template/pull/261))

# 0.19.1

- Have focus outline appear outside of element rather than covering it in Safari and Chrome ([PR #259](https://github.com/alphagov/govuk_template/pull/259))

# 0.19.0

- Remove external link styles ([PR #231](https://github.com/alphagov/govuk_template/pull/231))
- Remove extraneous copy of HTML5shiv that wasn’t being used ([PR #254](https://github.com/alphagov/govuk_template/pull/254))
- Update govuk_frontend_toolkit to latest version ([PR #256](https://github.com/alphagov/govuk_template/pull/256))

# 0.18.3

- Add docs for adding `tabindex="-1"` to fix the skiplink ([PR #250](https://github.com/alphagov/govuk_template/pull/250))
- Logo fixes: Fix logo breaking layout when increasing font size, fix invalid or non-standard CSS and remove obsolete CSS around logo, adjust logo dimensions slightly ([PR #237](https://github.com/alphagov/govuk_template/pull/237))

# 0.18.2

- Degrade gracefully when external JS can’t be loaded ([PR #248](https://github.com/alphagov/govuk_template/pull/248))

# 0.18.1

- Remove gov.uk prefix from relative links when printing ([PR #234](https://github.com/alphagov/govuk_template/pull/234))
- Fix a `.visually-hidden` bug on GOV.UK ([PR #177](https://github.com/alphagov/govuk_template/pull/177))

# 0.18.0

- Publish the Jinja version of the template to NPM
- Update HTML5 Shiv to the latest version
- Remove an errant font loader script that was only being used for IE8

# 0.17.3

- Fix colour of H2 headings in footer

# 0.17.2

- Fix a bug with the skip-to-content link and iOS Voiceover
- Migrate @viewport statement from govuk_frontend_toolkit

# 0.17.1

- Reduce file size of template: removes HTML comments, `type` attributes on
  scripts, and uses HTML5 charset declaration. #208
- Switch external link media query to be mobile first #205
- Sass file cleanups
  - Replace old grid mixins with newer grid from frontend toolkit #134
  - Remove duplicate grey variables #201

# 0.17.0

- Add CSS hook (`.js-hidden`) for hiding content when JS is enabled. Some apps
  have an equivalent hook, which can be removed once upgraded to this version

# 0.16.4

- Fix publish the Jinja version of the template with a `package.json` for those
  consuming it with NPM

# 0.16.3

- make the Django version of the template into a proper Python package
- publish the Jinja version of the template with a `package.json` for those
  consuming it with NPM

# 0.16.2

- more static assets added to `assets.precompile` to improve
  compatibility with apps running rails > 4.2.5

# 0.16.1

- Fix colour of logo when in `:active` state

# 0.16.0

- Add Django template

# 0.15.1

- Fix copyright logo in Ruby version

# 0.15.0

- Add print specific logo styles

# 0.14.3

- Fix jumping logo on hover

# 0.14.2

- Drop Windows Safari font printing workaround as the font is no longer used in print
- Update the logo to print black-on-white instead of white-on-black

# 0.14.1

- Stop copyright entity being escaped in Jinja template

# 0.14.0

- Update Crown Copyright link to new URL
- Update the font-files and move woffs into CSS
- All user-visible text in the template can now be overridden. Some template languages which don't support default values (such as plain mustache) will therefore lose that text and require you to handle supplying the default.

# 0.13.0

- Add WebJar package
- Bump govuk_frontend_toolkit to 3.5.1
- Add `homepage_url` for overriding the href for the header logo link ("https://www.gov.uk" by default)
- Add `global_header_text` for overriding the header logo text ("GOV.UK" by default)
- Removed deprecated grid layout mixins: https://github.com/alphagov/govuk_template/pull/129

# 0.12.0

- Add: `body_start` to enable html to be placed at the first element of the body
- Add: option to have a single navigation link rather than a full menu

# 0.11.0

- Add support for Embedded JavaScript templates

# 0.10.1

- Add 16x16 favicon for non-retina screens
- Force scrollbar to always display on IE10/11
- Release documents in gh-pages branch
- Fix chunky Firefox fonts

# 0.10.0

- Update OGL link text and destination in footer
- Remove h2 from footer, replacing with `<p>` tag
- Add display: block to HTML5 `<main>` tags
- Set page background colour to match footer background colour

# 0.9.1

- Bump govuk_frontend_toolkit to reset font for print stylesheets

# 0.9.0

- Bump govuk_frontend_toolkit to get new visited link colour
- Add missing params in play template
- Update iOS icon sizes to latest documented by Apple
- Add underline on propositional name links
- Remove star hack in favour of IE specific stylesheet
