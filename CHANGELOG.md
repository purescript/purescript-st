# Changelog

Notable changes to this project are documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

Breaking changes:

New features:

Bugfixes:

Other improvements:

## [v6.2.0](https://github.com/purescript/purescript-st/releases/tag/v6.2.0) - 2022-09-30

New features:
- Add Semigroup and Monoid instances (#51 by @PureFunctor)

## [v6.1.0](https://github.com/purescript/purescript-st/releases/tag/v6.1.0) - 2022-09-26

New features:
- Adds uncurried ST functions with similar signatures and purposes as effect uncurried functions (#52 by @mikesol)

## [v6.0.0](https://github.com/purescript/purescript-st/releases/tag/v6.0.0) - 2022-04-27

Breaking changes:
- Migrate FFI to ES modules (#47 by @kl0tl and @JordanMartinez)

New features:

Bugfixes:

Other improvements:

## [v5.0.1](https://github.com/purescript/purescript-st/releases/tag/v5.0.1) - 2021-04-27

Other improvements:
- Fix warnings revealed by v0.14.1 PS release (#43 by @JordanMartinez)

## [v5.0.0](https://github.com/purescript/purescript-st/releases/tag/v5.0.0) - 2021-02-26

Breaking changes:
- Added support for PureScript 0.14 and dropped support for all previous versions (#37)

New features:
- Add roles declarations to allow safe coercions (#37)

Bugfixes:

Other improvements:
- Removed primes from foreign module exports (#29) 
- Migrated CI to GitHub Actions and updated installation instructions to use Spago (#38)
- Added a changelog and pull request template (#40, #41)

## [v4.1.1](https://github.com/purescript/purescript-st/releases/tag/v4.1.1) - 2020-03-04

- Re-release with `v` tag prefix for package-sets

## [4.1.0](https://github.com/purescript/purescript-st/releases/tag/4.1.0) - 2020-02-23

- Added `Global` region that allows `ST` computations to run in a global context or be converted to `Effect`
- Added `MonadST` class

## [v4.0.1](https://github.com/purescript/purescript-st/releases/tag/v4.0.1) - 2019-11-02

- Fix a typo in the documentation for `ST.run` (@jy14898)
- Fix some unused import warnings (@Ebmtranceboy)

## [v4.0.0](https://github.com/purescript/purescript-st/releases/tag/v4.0.0) - 2018-05-23

- Updated for PureScript 0.12
- `ST` is now a type of its own rather than integrating with effects
- The names in `STRef` have been shortened for less repetition with qualified imports
- The argument order of functions has changed so the `STRef` is always in the last position

## [v3.0.0](https://github.com/purescript/purescript-st/releases/tag/v3.0.0) - 2017-03-26

- Updated for PureScript 0.11

## [v2.0.0](https://github.com/purescript/purescript-st/releases/tag/v2.0.0) - 2016-10-02

- Updated dependencies

## [v1.0.0](https://github.com/purescript/purescript-st/releases/tag/v1.0.0) - 2016-06-01

This release is intended for the PureScript 0.9.1 compiler and newer.

**Note**: The v1.0.0 tag is not meant to indicate the library is “finished”, the core libraries are all being bumped to this for the 0.9 compiler release so as to use semver more correctly.

## [v0.1.1](https://github.com/purescript/purescript-st/releases/tag/v0.1.1) - 2015-09-12

- Simplify the type of `pureST`.

## [v0.1.0](https://github.com/purescript/purescript-st/releases/tag/v0.1.0) - 2015-06-30

Initial release. This release works with versions 0.7.\* of the PureScript compiler. It will not work with older versions. If you are using an older version, you should require an older, compatible version of this library.
