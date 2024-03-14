# frozen_string_literal: true

require_relative "which/version"
require_relative "which/executable"

# A cross-platform way of finding an executable in the $PATH.
#
#   ::Which.('ruby') #=> /usr/bin/ruby
module Which
  Error = Class.new(StandardError)

  def self.call(cmd)
    Executable.find(cmd)
  end
end
