# Integration Tests

When we make changes to govuk_template, we want to know that the changes don't break integration with clients.

This directory contains example integrations for compilation targets of govuk_template so that we can test two things:

* is the compiled template still syntactically valid?
* has the API changed - has it required any changes in the app?

This is achieved by getting each app to render HTML from the template, saving it into `./html_for_testing` and then running assertions against each of those HTML files.
