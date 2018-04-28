#! /bin/bash
set -e

rm -rf vendor/mustache_idsk_template/*

# TODO: Pick the latest, not every matching tgz file!
tar -zxvf ../../../pkg/mustache_idsk_template-*.tgz -C vendor/

bundle install --path vendor/bundle

bundle exec ruby test_render.rb
