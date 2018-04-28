# ID-SK Template

This provides a template containing the ID-SK header and footer, and associated assets. It provides a consistent ID-SK brand experience across government services in Slovakia.

The template is built from [`source`](source/) files, and multiple packages are generated to support different languages and frameworks.

Packages are available for [RubyGems](https://rubygems.org/gems/idsk_template), NPM ([mustache](https://npmjs.org/package/idsk_template_mustache), [ejs](https://npmjs.org/package/idsk_template_ejs),  [jinja](https://npmjs.org/package/idsk_template_jinja)), and other [templating languages](docs/packaging.md).


## Previewing the template

You can [view a collection of auto-generated examples](https://id-sk.github.io/idsk_template/) of the current idsk_template release, which show how you can use the template.

## Requirements

The Ruby language (1.9.3+), the build tool [Rake](https://github.com/ruby/rake) & the dependancy management tool [Bundler](https://bundler.io/)

## Detailed Docs

* [Development](docs/development.md)
* [Packaging](docs/packaging.md)
* [Publishing](docs/publishing.md)

## Usage

* [Using with Rails](docs/using-with-rails.md)
* [ID-SK template blocks and their default values (how to customise the template)](docs/template-blocks.md)
* [Setting a Skip link](docs/usage.md#skip-link)
* [Propositional title and navigation](docs/usage.md#propositional-title-and-navigation)

## Contributing

Please follow the [contribution guidelines](https://github.com/id-sk/idsk_template/blob/master/CONTRIBUTING.md).

This is versioned following [Semantic Versioning](http://semver.org).
