require_relative 'lib/squirrel_census/version'

Gem::Specification.new do |spec|
  spec.name          = "squirrel_census"
  spec.version       = SquirrelCensus::VERSION
  spec.authors       = ["d-otis"]
  spec.email         = ["dan@dan-foley.com"]

  spec.summary       = "CLI for Investigating Central Park Squirrel Census of 2018"
  spec.homepage      = "https://github.com/d-otis/squirrel_census_cli"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/d-otis/squirrel_census_cli"
  spec.metadata["changelog_uri"] = "https://github.com/d-otis/squirrel_census_cli"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'ruby_figlet'
  spec.add_dependency 'json'
  spec.add_development_dependency 'pry'
end
