#! /bin/bash
set -e

rm -rf vendor/jinja_idsk_template/*

mkdir -p vendor/jinja_idsk_template

# strip-components lets us decompress into a directory without a version number
# TODO: Pick the latest, not every matching tgz file!
tar -zxf ../../../pkg/jinja_idsk_template-*.tgz -C vendor/jinja_idsk_template --strip-components 1

# --user param allows installing without sudo:
pip install virtualenv --user
virtualenv .env
source .env/bin/activate

pip install jinja2

python build.py
