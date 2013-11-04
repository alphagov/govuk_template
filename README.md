# GovukTemplate

This provides a template containing the GOV.UK header and footer, and associated assets.

This is versioned following [Semantic Versioning](http://semver.org).

## Packaging

At present this generates 4 output formats:

1. a gem containing a Rails engine
2. a tarball containing Play Framework templates
3. a folder containing mustache templates
4. a tarball.

### Gem version

This is available on rubygems.org.  To use it, add this line to your application's Gemfile:

    gem 'govuk_template'

And then execute:

    $ bundle

You can then use the `govuk_template` layout in your app.  If you need to extend the layout you can use [nested layouts](http://guides.rubyonrails.org/layouts_and_rendering.html#using-nested-layouts).

### Play version

To generate the tarball of Play Framework templates run `build:play` rake task. This will produce a tarball in the `pkg` directory.

### Mustache version

To generate the folder of Mustache templates run `build:mustache` rake task. This will produce a folder in the `pkg` directory.

### Tarball version

To generate the tarball, run the `build:tar` rake task.  This will produce a tarball in the `pkg` directory.

## Development

The source files are in the `/source` directory.  The `compile` rake task builds the `/app` contents from these sources.  This process involves the following:

* compiling all stylesheets referenced in `/manifests.yml` to plain css (actually css.erb, so the Rails asset pipeline can work in the gem).
* combining all javascripts referenced in `/manifests.yml` (using Sprockets)
* copying the images across (including any needed images from the toolkit)

This resulting app directory is included in the gem and hooked in as a Rails engine

### Extra details for the tarball build

The tarball build process takes the compiled template and assets from the `/app` directory, and performs some extra processing:

* it compiles the `*.css.erb` files to plain css, replacing all calls to `asset_path` with the relative path to the asset.
  For this reason, all assets referenced in the stylesheets must be stored relative to the stylesheet.
* it compiles the erb layout to plain html.
    * All `asset_path` calls are replaced by the the path to the assets, assuming the assets folder is served from /assets
    * Any `content_for?` calls are assumed to return false
    * yields in the template are removed except for the main layout one which is replaced with an HTML comment.

See the `TemplateProcessor` class for details of this implementation.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Run the tests (`bundle exec rake`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
