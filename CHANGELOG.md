# Changelog

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
