# Changing icons

## To do when changing icons in idsk_template

An example of icons being changed can be found [here](https://github.com/alphagov/govuk_template/pull/300/commits/1e82126c13c7e420463d17f0fe90b44c3f43417c)

In this case we also need to add new icons to `lib/idsk_template/engine.rb`. See example commit [here](https://github.com/alphagov/govuk_template/commit/ff3bdd766198f0f6b1270ec712bcff66b3bd73f4)

## Updating tests in projects that use idsk_template

We will use `static` as an example. When icons are updated, you will also have to update the following files in static
in order to be able to use the new version of the gem:

- `test/integration/icon_redirects_test.rb`
- `config/routes.rb`
