# frozen_string_literal: true

require_relative "lib/e2e_testing_on_rails/version"

Gem::Specification.new do |spec|
  spec.name          = "e2e_testing_on_rails"
  spec.version       = E2eTestingOnRails::VERSION
  spec.authors       = ["YusukeIwaki"]

  spec.summary       = "Utility library for E2E testing on Rails."
  spec.homepage      = "https://github.com/YusukeIwaki/e2e_testing_on_rails"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/}) || f.include?('.git')
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
