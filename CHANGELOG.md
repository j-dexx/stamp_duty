# Changelog

## 0.3.0

### Breaking

- `StampDuty.for` returns an immutable `StampDuty::Calculation`. `ResidentialCalculator`
  and `BandSelector` are removed.
- `Band` and `BandAmount` are immutable value objects built with keyword arguments.
  `BandAmount` takes the band's taxable amount instead of `price:`.
- Band descriptions use £ and HMRC-style wording ("£125,001 to £250,000", "Above £1,500,000").

### Added

- First-time buyer relief (`first_time_buyer: true`).
- Higher rates for additional properties (`additional_property: true`).
- Non-UK resident surcharge (`non_resident: true`).
- `to_h` on results.
- RBS type signatures.

### Changed

- Releases published from GitHub Actions via RubyGems trusted publishing.
- Dependabot for bundler and GitHub Actions.
- Linting with standard; bundler-audit in CI.
- Actions pinned to exact versions.

## 0.2.0

### Breaking

- Requires Ruby 3.3 or later.
- `stamp_duty` is rounded down to the whole pound, matching HMRC.
- Invalid prices (non-numeric, `nil`, negative, NaN, infinite) raise `ArgumentError`.
  Numeric strings such as `"275000"` are no longer accepted.

### Fixed

- Gem failed to load on Ruby 3.x (`uninitialized constant Forwardable`).
- Calling `calculate` more than once doubled the result.
- `stamp_duty` returned 0 unless `calculate` had been called first; results are now computed lazily.

### Changed

- Declared `bigdecimal` as a runtime dependency (bundled gem from Ruby 3.4).
- Updated development dependencies (rake 13, minitest 5.25, simplecov 0.22); dropped mocha and pry.
- Require MFA for gem pushes (`rubygems_mfa_required`).
- CI moved from Travis to GitHub Actions.

## 0.1.0

- Initial release.
