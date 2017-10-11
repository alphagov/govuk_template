# Travis Credentials

## GitHub

For publishing packages to GitHub, we are using a GitHub token belonging to
[govuk-design-system-ci](https://github.com/govuk-design-system-ci).

This is provided as an environment variable which is encrypted in travis.yml

## NPM & RubyGems

NPM and RubyGems credentials are provided as encrypted config files in .travis.

Because Travis will only allow you to encrypt one file, we have to archive both
files inside a tar archive which is then encrypted.

### Updating the NPM and RubyGems credentials

You cannot (easily) decrypt the archive, so the simplest thing to do is to
recreate both files using the details from the credentials store.

Firstly, create a `secrets` directory.

Copy the auth credentials for RubyGems and NPM into these files:

`secrets/gem_credentials`:

```
---
:rubygems_api_key: RUBYGEMS_API_KEY
```

`secrets/npmrc`:

```
//registry.npmjs.org/:_authToken=NPM_API_KEY
```

You can then tar the two files into an archive:

```
tar cvf .travis/secrets.tar secrets/npmrc secrets/gem_credentials
```

Finally, encrypt the secrets.tar file following [Travis'
documentation](https://docs.travis-ci.com/user/encrypting-files/).

Ensure you have the Travis command line tool installed and you are logged in.

```
travis encrypt-file .travis/secrets.tar --org
```

The `--org` flag specifies using travis-ci.org rather than travis-ci.com.

The output will look like this:

```
- openssl aes-256-cbc -K $encrypted_df4ab1bff570_key -iv $encrypted_df4ab1bff570_iv -in secrets.tar.enc -out secrets.tar -d
```

Move the generated encrypted archive into .travis subfolder.

Copy the output from the Travis command line tool into config.sh and update the
output to include the missing .travis/ directory.

```
- openssl aes-256-cbc -K $encrypted_df4ab1bff570_key -iv $encrypted_df4ab1bff570_iv -in .travis/secrets.tar.enc -out .travis/secrets.tar -d
```

Commit both .travis/secrets.tar.enc and the updated config file.

Remove the unencrypted secrets directory.
