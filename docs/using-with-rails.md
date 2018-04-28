# Using with Rails

## Add to Gemfile

Add `idsk_template` to your app's `Gemfile`:

```ruby
gem 'idsk_template'
```

(In a production system you'll want to pin a more specific version for stability)

## Use the layout

Add this line to the bottom of your application layout view (usually in `app/views/layouts/application.html.erb`):

```erb
<%= render file: 'layouts/idsk_template' %>
```

## Customise the template

`idsk_template` provides blocks you can insert content into, to customise the basic layout.

For example, to set a `<title>` for your page you can set content for the `:page_title` block, and it will be inserted into the `idsk_template` layout.:

```
<% content_for :page_title, "My page title" %>
```

Or to add content to `<head>`, for stylesheets or similar:

```
<% content_for :head do %>
  <%= stylesheet_link_tag 'application', media: 'all' %>
  <%= csrf_meta_tags %>
<% end %>
```

Check out the [full list of blocks](template-blocks.md) you can use to customise the template.

## SRI

`idsk_template` >= 20.0.0 can be used together with `sprockets-rails` >= 3.0.0 in order to make use of the SRI

You can read more about SRI [here](https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity).

SRI will add an `integrity` attribute on your script tags:

`<script src="https://example.com/example.css"
integrity="sha384oqVuAfXRKap7fdgcCY5uykM6+R9GqQ8K/uxy9rx7HNQlGYl1kPzQho1wx4JwY8w"
crossorigin="anonymous"></script>`

The example above is generated automatically by sprockets-rails in your project if the integrity option is set to true:

`<%= stylesheet_script_tag 'example', integrity: true %>`

There is [a bug in Firefox versions less than 52](https://bug623317.bugzilla.mozilla.org/show_bug.cgi?id=1269241) which means it interprets the SRI hash incorrectly for CSS files that start with [the UTF8 byte order mark (BOM)](https://en.wikipedia.org/wiki/Byte_order_mark#UTF-8).  Sprockets-rails will include a UTF8 BOM in the compiled CSS file if any of the source stylesheets have UTF8 characters in them and this means Firefox < 52 will refuse to load these assets.  To avoid this we developed the [asset_bom_removal-rails](https://github.com/alphagov/asset_bom_removal-rails) gem to strip the UTF8 BOM from compiled CSS assets as part of the rails asset pipeline.
