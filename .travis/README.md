# Travis encrypted files

We are using a GitHub token attached to the [govuk-ci](https://github.com/govuk-ci) user.

To encrypt files for Travis:

Create secrets directory with two sub directories, one for the gem credentials and the other for the npm credentials.

```
secrets/gem_credentials
secrets/npmrc
```

Copy the auth credentials for RubyGems and NPM into these files.

secrets/gem_credentials
```
---
:rubygems_api_key: redacted
```

secrets/npmrc
```
//registry.npmjs.org/:_authToken=YOUR_API_KEY
```

Travis will only allow you to encrypt one file, next create a tar archive
inside the .travis directory.

```
tar cvs .travis/secrets.tar sectrets/npmrc secrets/gem_credentials
```

Encrypt the secrets.tar file following these docs:
https://docs.travis-ci.com/user/encrypting-files/

Ensure you have the Travis command line tool installed and you are logged in.

```
travis encrypt-file .travis/secrets.tar --org
```

Note: use --org to prevent the error "Repo not found"

The output will look like this:

```
- openssl aes-256-cbc -K $encrypted_df4ab1bff570_key -iv $encrypted_df4ab1bff570_iv -in secrets.tar.enc -out secrets.tar -d
```

Copy the output from the Travis command line tool into  the before_install step in `.travis.yml` update the output to include the missing .travis/ directory.

```
- openssl aes-256-cbc -K $encrypted_df4ab1bff570_key -iv $encrypted_df4ab1bff570_iv -in .travis/secrets.tar.enc -out .travis/secrets.tar -d
```

Commit both .travis/secrets.tar.enc and the updated config file.

Remove the unencrypted secrets directory.
