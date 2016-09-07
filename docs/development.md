# Development

The source files are in the `/source` directory.  The `compile` rake task builds the `/app` contents from these sources.  This process involves the following:

* compiling all stylesheets referenced in `/manifests.yml` to plain CSS (actually css.erb, so the Rails asset pipeline can work in the gem).
* combining all JavaScript files referenced in `/manifests.yml` (using Sprockets)
* inserting integrity values for the above CSS/JS into empty integrity attributes in the template
* copying the images across (including any needed images from the toolkit)

This resulting app directory is included in the gem and hooked in as a Rails engine

## Extra details for the tarball build

The tarball build process takes the compiled template and assets from the `/app` directory, and performs some extra processing:

* it compiles the `*.css.erb` files to plain CSS, replacing all calls to `asset_path` with the relative path to the asset.
  For this reason, all assets referenced in the stylesheets must be stored relative to the stylesheet.
* it compiles the erb layout to plain html.
    * All `asset_path` calls are replaced by the the path to the assets, assuming the assets folder is served from /assets
    * Any `content_for?` calls are assumed to return false
    * yields in the template are removed except for the main layout one which is replaced with an HTML comment.

See the `TemplateProcessor` class for details of this implementation.

### Testing

Run the tests with:

    bundle exec rake

The integration tests are run separately with:

    bundle exec rake integration_tests

For more details, see [integration_tests/README.md](integration_tests/README.md).
