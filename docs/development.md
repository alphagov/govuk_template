# Development

The source files are in the `/source` directory.  The `compile` rake task builds the `/app` contents from these sources.  This process involves the following:

* compiling all stylesheets referenced in `/manifests.yml` to plain CSS (actually css.erb, so the Rails asset pipeline can work in the gem).
* combining all JavaScript files referenced in `/manifests.yml` (using Sprockets)
* copying the images across (including any needed images from the toolkit)

This resulting app directory is included in the gem and hooked in as a Rails engine

## Getting a manual test rig setup

You will need a 'test website' to manually verify changes. If you're only modifying the existing assets, you can do this with NodeJS.

```
# Serve all the assets in the current directory
npx http-server -c-1

# Auto-compile all the SASS to CSS
npx node-sass --recursive source/assets/stylesheets --output app/assets/stylesheets --include-path ../idsk_frontend_toolkit/stylesheets --watch
```

Then create a skeleton `test.html` file in the `app` directory (so git ignores it) using the following template.

```
<html>
  <head>
    <link rel="stylesheet" href="assets/css/idsk-template.css"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  </head>
  <body class="js-enabled">
    YOUR TEST CODE HERE
  </body>
  <script type="text/javascript" src="../source/assets/javascripts/idsk-template.js"></script>
</html>
  </body>
</html>
```

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
