fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios test

```sh
[bundle exec] fastlane ios test
```

Runs all the tests

### ios update_versions

```sh
[bundle exec] fastlane ios update_versions
```

Update the version numbers of the project

### ios beta

```sh
[bundle exec] fastlane ios beta
```

Submit a new beta build to Apple TestFlight

### ios dev

```sh
[bundle exec] fastlane ios dev
```

Set up developer environment

### ios certs

```sh
[bundle exec] fastlane ios certs
```

Regenerate all signing certs

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
