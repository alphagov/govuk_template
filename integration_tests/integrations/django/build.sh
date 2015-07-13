#! /bin/bash
set -e

rm -rf vendor/django_govuk_template/*

mkdir -p vendor/django_govuk_template

# strip-components lets us decompress into a directory without a version number
# TODO: Pick the latest, not every matching tgz file!
tar -zxf ../../../pkg/django_govuk_template-*.tgz -C vendor/django_govuk_template --strip-components 1

sudo pip install Django

python build.py
