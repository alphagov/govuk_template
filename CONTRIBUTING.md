# Contribution Guidelines

We welcome patches as long as you follow these guidelines:

## Git workflow ##

- Pull requests must contain a succinct, clear summary of what the user need is driving this feature change.
- Follow Alphagov [Git styleguide](https://github.com/alphagov/styleguides/blob/master/git.md)
- Make a feature branch
- Ensure your branch contains logical atomic commits before sending a pull request - follow Alphagov [Git styleguide](https://github.com/alphagov/styleguides/blob/master/git.md)
- Pull requests are automatically integration tested, where applicable using [Travis CI](https://travis-ci.org/), which will report back on whether the tests still pass on your branch
- You *may* rebase your branch after feedback if it's to include relevant updates from the master branch. We prefer a rebase here to a merge commit as we prefer a clean and straight history on master with discrete merge commits for features

## Copy ##

- Follow the GOV.UK [style guide](https://www.gov.uk/designprinciples/styleguide)
- URLs should use hyphens, not underscores

## Code ##

- Must be readable with meaningful naming, eg no short hand single character variable names
- Follow our [Ruby style guide](https://github.com/alphagov/styleguides/blob/master/ruby.md)

## Testing ##

Write tests when adding or changing functionality.

Run the tests with:

```bash
bundle exec rake spec integration_tests
```

## Versioning ##

We use [Semantic Versioning](http://semver.org/).

### Releasing a new version ###

1. Create a branch that proposes a new [version number](/lib/idsk_template/version.rb#L2), and [`CHANGELOG`](CHANGELOG.md)
2. Open a Pull Request - here is a [good example](https://github.com/alphagov/govuk_template/pull/204/)
3. Once merged into master a new version will be built and [published](docs/publishing.md)
