# Contribution Guidelines

**Note:** If these contribution guidelines are not followed your issue or PR might be closed, so
please read these instructions carefully.

## Contribution types

### Bug Reports

- If you find a bug, please first report it using [Github issues].
- First check if there is not already an issue for it; duplicated issues will be closed.

### Bug Fix

- If you'd like to submit a fix for a bug, please read the [How To](#how-to-contribute) for how to
  send a Pull Request.
- Indicate on the open issue that you are working on fixing the bug and the issue will be assigned
  to you.
- Write `Fixes #xxxx` in your PR text, where xxxx is the issue number (if there is one).
- Include a test that isolates the bug and verifies that it was fixed.

### New Features

- If you'd like to add a feature to the library that doesn't already exist, feel free to describe
  the feature in a new [GitHub issue].
- If you'd like to implement the new feature, please wait for feedback from the project maintainers
  before spending too much time writing the code. In some cases, enhancements may not align well
  with the project future development direction.
- Implement the code for the new feature and please read the [How To](#how-to-contribute).

### Documentation & Miscellaneous

- If you have suggestions for improvements to the documentation, tutorial or examples (or something
  else), we would love to hear about it.
- As always first file a [Github issue].
- Implement the changes to the documentation, please read the [How To](#how-to-contribute).

## How To Contribute

### Requirements

For a contribution to be accepted :

- Format your code;
- Documentation should always be updated or added (if applicable);
- The PR title should start with a [conventional commit] prefix (`feat:`, `fix:` etc).

If the contribution doesn't meet these criteria, a maintainer will discuss it with you on the issue
or PR. You can still continue to add more commits to the branch you have sent the Pull Request from
and it will be automatically reflected in the PR.

### Environment Setup

Scriny is setup to run with the most recent `stable` version of Flutter, so make sure your version
matches that :

```shell
flutter channel stable
```

### Performing changes

- Create a new local branch from `master` (e.g. `git checkout -b my-new-feature`)
- Make your changes (try to split them up with one PR per feature/fix).
- When committing your changes, make sure that each commit message is clear
  (e.g. `git commit -m 'My very clear commit message'`).
- Push your new branch to your own fork into the same remote branch
  (e.g. `git push origin my-username.my-new-feature`, replace `origin` if you use another remote.)

### Breaking changes

When doing breaking changes a deprecation tag should be added when possible and contain a message
that conveys to the user what which version that the deprecated method/field will be removed in and
what method they should use instead to perform the task. The version specified should be at least
two versions after the current one, such that there will be at least one stable release where the
users get to see the deprecation warning and in the version after that (or a later version) the
deprecated entity should be removed.

Example (if the current version is v4.1.0):

```dart
@Deprecated('Will be removed in v4.2.0, use nonDeprecatedFeature() instead')
void deprecatedFeature() {}
```


### Open a pull request

Go to the [pull request page of Scriny][PRs] and in the top
of the page it will ask you if you want to open a pull request from your newly created branch.

The title of the pull request should start with a [conventional commit] type.

Allowed types are:

- `fix:` -- patches a bug and is not a new feature;
- `feat:` -- introduces a new feature;
- `docs:` -- updates or adds documentation or examples;
- `test:` -- updates or adds tests;
- `refactor:` -- refactors code but doesn't introduce any changes or additions to the public API;
- `perf:` -- code change that improves performance;
- `build:` -- code change that affects the build system or external dependencies;
- `ci:` -- changes to the CI configuration files and scripts;
- `chore:` -- other changes that don't modify source or test files;
- `revert:` -- reverts a previous commit.

If you introduce a **breaking change** the conventional commit type MUST end with an exclamation
mark (e.g. `feat!: Remove the position argument from PositionComponent`).

## Maintainers

These instructions are for the maintainers of Scriny.

### Merging a pull request

When merging a pull request, make sure that the title of the merge commit has the correct
conventional commit tag and a descriptive title. This is extra important since sometimes the title
of the PR doesn't reflect what GitHub defaults to for the merge commit title (if the title has been
changed during the life time of the PR for example).

All the default text should be removed from the commit message and the PR description and the
instructions from the "Migration instruction" (if the PR is breaking) should be copied into the
commit message.

### Creating a release

There are a few things to think about when doing a release:

- Search through the codebase for `@Deprecated` methods/fields and remove the ones that are marked
  for removal in the version that you are intending to release.
- Create a PR containing the changes for removing the deprecated entities.
- Run `dart run scriny:version` and follow the steps. Do not foget 

- Go through the PRs with breaking changes and add migration documentation to the changelog.
  There should be migration docs on each PR, if they haven't been copied to the commit message.
- Run `melos publish` to make sure that there aren't any problems with any of the packages and make
  sure that all the versions are correct.
- Once you are satisfied with the result of the dry run, run `melos publish --no-dry-run`
- Create a PR containing the updated changelog and `pubspec.yaml` files.

[GitHub issue]: https://github.com/Skyost/Scriny/issues
[GitHub issues]: https://github.com/Skyost/Scriny/issues
[PRs]: https://github.com/Skyost/Scriny/pulls
[Melos]: https://github.com/invertase/melos
[pubspec doc]: https://dart.dev/tools/pub/pubspec
[conventional commit]: https://www.conventionalcommits.org
