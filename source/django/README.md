# Django version of the GOV.UK template

This repository is the **Django** version of the [govuk_template](https://github.com/alphagov/govuk_template).

You can add it to your Django application's dependencies from here.

## Installation

Add the package to your requirements:
```
git+https://github.com/alphagov/govuk_template_django.git
```

Add the package to your installed apps:
```python
INSTALLED_APPS = [
	...,
	'govuk_template'
]
```

Now you can extend the GOV.UK base in your templates:
```django
{% extends "govuk_template/base.html" %}
```

## Build

This repo is automatically built from the [govuk_template](https://github.com/alphagov/govuk_template). when the version number is changed in that repository. Please don't send pull requests here for anything but this README, send them to [govuk_template](https://github.com/alphagov/govuk_template). instead. They'll end up here when the template is updated.
