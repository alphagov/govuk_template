# Using with Rails

## Add to Gemfile

Add `govuk_template` to your app's `Gemfile`:

```ruby
gem 'govuk_template'
```

(In a production system you'll want to pin a more specific version for stability)

## Use the layout

Add this line to the bottom of your application layout view (usually in `app/views/layouts/application.html.erb`):

```erb
<%= render file: 'layouts/govuk_template' %>
```

## Customise the template

`govuk_template` provides blocks you can insert content into, to customise the basic layout.

For example, to set a `<title>` for your page you can set content for the `:page_title` block, and it will be inserted into the `govuk_template` layout.:

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

`govuk_template` >= 20.0.0 can be used together with `sprockets-rails` >= 3.0.0 in order to make use of the SRI 

You can read more about SRI [here](https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity).

SRI will add an `integrity` attribute on your script tags:

`<script src="https://example.com/example.css" 
integrity="sha384oqVuAfXRKap7fdgcCY5uykM6+R9GqQ8K/uxy9rx7HNQlGYl1kPzQho1wx4JwY8w" 
crossorigin="anonymous"></script>`

The example above is generated automatically by sprockets-rails in your project if the integrity option is set to true:

`<%= stylesheet_script_tag 'example', integrity: true %>`

