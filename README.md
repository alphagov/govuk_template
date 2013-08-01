# GovukTemplate

This provides a template containing the GOV.UK header and footer, and associated assets.

This is versioned following [Semantic Versioning](http://semver.org).

## Packaging

At present this generates 2 output formats, a gem containing a Rails engine, and a tarball.

### Gem version

This is currently released to our gemfury account, and not to rubygems.org.  Once the shape of this has stabilised (probably 
when we release 1.0.0), it will be released to rubygems.org.

To use it, add this line to your application's Gemfile (you'll need to add the gemfury source as well if it's not already in there):

    gem 'govuk_template'

And then execute:

    $ bundle

You can then use the `govuk_template` layout in your app.  If you need to extend the layout you can use [nested layouts](http://guides.rubyonrails.org/layouts_and_rendering.html#using-nested-layouts).

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
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
