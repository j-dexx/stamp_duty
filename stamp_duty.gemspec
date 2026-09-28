lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "stamp_duty/version"

Gem::Specification.new do |spec|
  spec.name = "stamp_duty"
  spec.version = StampDuty::VERSION
  spec.authors = ["James Doyley"]
  spec.email = ["jdoyley@gmail.com"]

  spec.summary = " A UK property stamp duty calculator "
  spec.homepage = "https://github.com/j-dexx/stamp_duty"
  spec.license = "MIT"

  spec.metadata = {
    "source_code_uri" => spec.homepage,
    "changelog_uri" => "#{spec.homepage}/blob/master/CHANGELOG.md",
    "rubygems_mfa_required" => "true"
  }

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|bin|\.github)/}) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 3.3"

  spec.add_dependency "bigdecimal", ">= 3.1", "< 5"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.25"
  spec.add_development_dependency "simplecov", "~> 0.22"
  spec.add_development_dependency "standard", "~> 1.56"
  spec.add_development_dependency "bundler-audit", "~> 0.9"
  spec.add_development_dependency "rbs", "~> 4.2"
end
