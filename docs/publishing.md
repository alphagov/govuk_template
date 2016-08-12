# Publishing

Accepted contributions (pull requests merged into master) will run builds for the Gem, Play and Mustache versions. These will then update the following:

* The [ruby gems package](https://rubygems.org/gems/govuk_template)
* [alphagov/govuk_template_mustache](https://github.com/alphagov/govuk_template_mustache) which updates the [npm package](https://npmjs.org/package/govuk_template_mustache)
* [alphagov/govuk_template_ejs](https://github.com/alphagov/govuk_template_ejs) which updates the [npm package](https://npmjs.org/package/govuk_template_ejs)
* [alphagov/govuk_template_jinja](https://github.com/alphagov/govuk_template_jinja)

## How publishing works

When a new version is merged to master

### NPM

https://github.gds/gds/ci-deployment/blob/master/hieradata/env.production.yaml#L88-L89

- `ci_environment::jenkins_user::npm_auth`
- `ci_environment::jenkins_user::npm_email`

`.npmrc` template:
https://github.com/alphagov/ci-puppet/blob/4cc64f953d601aea6483d92ce101960014f4ee9a/modules/ci_environment/templates/npmrc.erb


#### Manually Publishing

Combine with the `.npmrc` template.

If you don't have access, talk to the GOV.UK infrastructure team - though long term this needs to be not owned by GOV.UK

eg:

```
email=govuk-dev@digital.cabinet-office.gov.uk
_auth=XXXX
```

Save it in your home directory as `~/.npmrc`. You can test it's working with `npm whoami`, which should show you logged in as `alphagov`.

Check out repo you want to publish to npm, eg https://www.npmjs.com/package/govuk_template_mustache

Within it, run: `npm publish`

Note: If the version you want to publish isn't the latest, then check out the tag you want, eg `git checkout v0.17.3`, and run `npm publish`.
