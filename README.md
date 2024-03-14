# A Unix-like which, for Ruby

Unix-like systems have long had a `which` command to identify the location to an executable.
This is a Ruby library that does the same thing, but works across Unix-like systems, and Windows, consistently.
It's meant for use within another Ruby library or application, rather than as a command line tool itself.

For example you might use it to auto-discover the path to a command line tool you need to shell out to.
Or similarly, to auto-configure the path to a command your tool is wrapping.
For example, a wrapper for Ghostscript might use `Which` to auto-configure the path to `gs`.

`Which` works by searching for the specified command along `$PATH`.
It takes care to use OS-specific `$PATH`-separators, as well as Windows-specific executable file extensions.
`Which` also ensures the command is actually executable, and is a file (and not a directory).

[ghostscript]: https://www.ghostscript.com "Ghostscript"

## Installation

Install the gem and add to the application's Gemfile:

```console
bundle add which
```

If Bundler is not being used to manage dependencies, install the gem:

``` console
gem install which
```

## Usage

When the command is on `$PATH`:

```ruby
Which.call("git") #=> "/opt/homebrew/bin/git"
# Or, an alternative syntax
Which.("git")     #=> "/opt/homebrew/bin/git"
```

Searching for a command NOT on `$PATH`

```ruby
Which.call("foobar") #=> nil
```

Searching for a non-executable command:

```ruby
Which.call("plain.txt") #=> nil
```

Searching for a directory, even if it's on `$PATH`

```ruby
Which.call("somedir") #=> nil
```

`Which` can also handle absolute paths to a command.
This can be useful for validating a command you already know about exists, and is executable.

```ruby
Which.call("/usr/local/bin/vim") #=> "/usr/local/bin/vim"

Which.call("/usr/local/bin/emacs") #=> nil
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `bin/spec` to run the tests.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

### Local Install
To install this gem onto your local machine, run `bin/rake install`.

### Cutting a new version

Update the version number in `version.rb`, and be sure the `CHANGELOG` is up to date.
Then run `bin/rake release`, which will

  1. create a git tag for the version
  1. push git commits and the created tag
  1. push the `.gem` file to [rubygems.org][rubygems]

[rubygems]: https://rubygems.org "RubyGems | Your community gem host"

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/stevenharman/which]().

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
