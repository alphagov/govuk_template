# Usage

## To customise the ID-SK template

Refer to the table of [template blocks](./docs/template-blocks.md) and their default values.

## Skip link

The [idsk_template sets a skip link](https://github.com/id-sk/idsk_template/blob/master/source/views/layouts/idsk_template.html.erb#L64-L68) to `#content`, but doesn't provide an element with `id="content"`. You'll need to add `id="content"` to your main content area, to ensure the skip link will work.

## Propositional title and navigation

You can get a propositional title and navigation by setting the content for `header_class` to `with-proposition` and `proposition_header` in the form:

    <div class="header-proposition">
      <div class="content">
        <a href="/" id="proposition-name">Service Name</a>
        <a role="button" href="#proposition-links" class="js-header-toggle menu" aria-controls="navigation" aria-label="Show or hide Top Level Navigation">Menu</a>
        <nav id="proposition-menu">
          <ul id="proposition-links" aria-label="Top Level Navigation">
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
        <a href='/' id='proposition-name'>Service Name</a>
        <nav id='proposition-menu' aria-label="Top Level Navigation">
          <p id='proposition-link'>
            <a href='url-to-page-1'>Navigation item #1</a>
          </p>
        </nav>
      </div>
    </div>
