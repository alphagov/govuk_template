# Usage

## To customise the GOV.UK template

Refer to the table of [template blocks](./docs/template-blocks.md) and their default values.

## Skip link

The [govuk_template sets a skip link](https://github.com/alphagov/govuk_template/blob/master/source/views/layouts/govuk_template.html.erb#L64-L68) to `#content`, but doesn't provide an element with `id="content"`. You'll need to add `id="content"` to your main content area, to ensure the skip link will work.

    <main id="content" role="main" tabindex="-1">

It is recommended to use the main element, with a role of main (to support older assistive technology), also `tabindex="-1"` is required to fix the issue [with focus in Safari](https://bugs.chromium.org/p/chromium/issues/detail?id=37721).

You can see an [example of this working in GOV.UK elements](https://github.com/alphagov/govuk_elements/blob/master/app/views/index.html#L9).


## Propositional title and navigation

You can get a propositional title and navigation by setting the content for `header_class` to `with-proposition` and `proposition_header` in the form:

    <div class="header-proposition">
      <div class="content">
        <a href="#proposition-links" class="js-header-toggle menu">Menu</a>
        <nav id="proposition-menu">
          <a href="/" id="proposition-name">Service Name</a>
          <ul id="proposition-links">
            <li><a href="url-to-page-1" class="active">Navigation item #1</a></li>
            <li><a href="url-to-page-2">Navigation item #2</a></li>
          </ul>
        </nav>
      </div>
    </div>

This will then create a navigation block which is shown on desktop sized devices but collapsed down on smaller screens.

For menus with only one item, the collapsible functionality is not necessary, it is recommended that you use the following markup

    <div class='header-proposition'>
      <div class='content'>
        <nav id='proposition-menu'>
          <a href='/' id='proposition-name'>Service Name</a>
          <p id='proposition-link'>
            <a href='url-to-page-1'>Navigation item #1</a>
          </p>
        </nav>
      </div>
    </div>
