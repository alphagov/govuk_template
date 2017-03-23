#!/bin/bash
set -e

REPO_PATH='alphagov/govuk_template'

echo "Add config for alphagov/$REPO_PATH"

git config --global user.name "Travis CI"
git config --global user.email "travis@travis-ci.org"

# This openssl command was generated automatically by `travis encrypt-file`, see `.travis/README.md` for more details
openssl aes-256-cbc -K $encrypted_df4ab1bff570_key -iv $encrypted_df4ab1bff570_iv -in .travis/secrets.tar.enc -out .travis/secrets.tar -d

tar xvf .travis/secrets.tar
mkdir -p ~/.gem/
mv secrets/gem_credentials ~/.gem/credentials
mv secrets/npmrc ~/.npmrc
