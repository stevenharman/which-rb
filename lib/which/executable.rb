require "pathname"

module Which
  class Executable
    def self.find(cmd)
      new.find(cmd)
    end

    def initialize(env: ENV)
      @env = env
    end

    def find(cmd)
      cmd_path = Pathname(cmd)
      return cmd_path.to_path if cmd_path.absolute? && executable_file?(cmd_path)

      extensions = fetch_executable_extensions
      env.fetch("PATH", "").split(File::PATH_SEPARATOR).each do |path|
        path = Pathname(path)

        extensions.each do |ext|
          file = path.join("#{cmd}#{ext}")
          return file.to_path if executable_file?(file)
        end
      end

      nil
    end

    private

    attr_reader :env

    def executable_file?(path)
      path.executable? && path.file?
    end

    def fetch_executable_extensions
      # Get list of executable extensions on Windows
      env.fetch("PATHEXT", "").split(";").tap do |extensions|
        # On non-Windows this is empty; add "" to search for extension-less files
        extensions.push("") if extensions.empty?
      end
    end
  end
end
