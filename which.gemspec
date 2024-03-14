# frozen_string_literal: true

require_relative "lib/which/version"

Gem::Specification.new do |spec|
  spec.name = "which"
  spec.version = Which::VERSION
  spec.authors = ["Steven Harman"]
  spec.email = ["steven@harmanly.com"]

  spec.summary = "Find the path to an executable on your system; Unix which, in Ruby."
  spec.description = <<~DESC
    Find the full path to an execuatble, based on the current $PATH and $PATHEXT (Windows).
    If the file is found, and it's executable, the full path is returned. Else, nil is returned.
    
        Which.call("git") #=> "/opt/homebrew/bin/git"
        Which.("git")     #=> "/opt/homebrew/bin/git"
        # Searching for a command NOT on $PATH
        Which.call("foobar") #=> nil
  DESC
  spec.homepage = "https://github.com/stevenharman/which"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata = {
    "changelog_uri" => "#{spec.homepage}/blob/main/CHANGELOG.md",
    "documentation_uri" => spec.homepage,
    "homepage_uri" => spec.homepage,
    "source_code_uri" => spec.homepage
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ spec/ .git .github Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
end
