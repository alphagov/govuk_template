#! /bin/bash
set -e

bundle install

bundle exec ruby simplicity.rb
