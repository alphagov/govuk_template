## ID-SK template blocks and their default values

| Template block name       |  Location / Information                         |   Default template values
|---                        |---                                              |---
| top_of_page               | Before doctype                                  | Insertion point
| html_lang                 | value of the HTML lang attribute                | en
| page_title                | Text inside the `<title>` element               | GOV.UK - The best place to find government services and information
| head                      | Before closing `</head>` element                | Insertion point
| body_classes              | Classes to be added to the `<body>` element     | Insertion point
| body_start                | After opening `<body>` element                  | Insertion point
| skip_link_message         | Text inside the skip to main content link       | Skip to main content
| cookie_message            | Text inside the cookie message banner           | `<p>GOV.UK uses cookies to make the site simpler. <a href="https://www.gov.uk/help/cookies">Find out more about cookies</a></p>`
| header_class              | `<header>` element                              | Set the value of header_class to [with-proposition](usage.md#propositional-title-and-navigation) to show the propositional navigation
| homepage_url              | URL of anchor element wrapping logo             | https://www.gov.uk/
| logo_link_title           | Title of anchor element wrapping logo           | Go to the GOV.UK homepage
| global_header_text        | Text next to the crown image                    | GOV.UK
| inside_header             | Inside parent `.header-global`                  | Insertion point
| proposition_header        | Inside parent `.header-wrapper`                 | Add a [propositional title and navigation links](usage.md#propositional-title-and-navigation)
| after_header              | After closing `</header>` element               | Insertion point
| content                   | Main content goes in here                       | Insertion point. Content must be wrapped with `id="content"` for the [skiplink to work](usage.md#skip-link).
| footer_top                | Inside parent `#footer-wrapper`                 | Insertion point
| footer_support_links      | Inside parent `.footer-meta-inner`              | Insertion point
| licence_message           | Open Government Licence text and link           | `<p>All content is available under the <a href="https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/" rel="license">Open Government Licence v3.0</a>, except where otherwise stated</p>`
| crown_copyright_message   | Copyright message                               | © Crown copyright
| body_end                  | Before closing `</body>` element                | Insertion point
