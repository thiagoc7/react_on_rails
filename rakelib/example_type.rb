module ReactOnRails
  class ExampleType
    # Gems we need to add to the Gemfile before bundle installing
    def self.required_gems
      ["gem 'react_on_rails', path: '../../.'", "gem 'therubyracer'"]
    end

    # Options we pass when running `rails new` from the command-line
    def self.rails_new_options
      "--skip-bundle --skip-spring --skip-git --skip-test-unit --skip-active-record"
    end

    attr_reader :name, :generator_options

    def initialize(name:, generator_options:)
      @name = name
      @generator_options = generator_options
    end

    def dir
      File.join(examples_dir, name)
    end

    def client_dir
      File.join(dir, "client")
    end

    def server_rendering?
      generator_options.include?("--server-rendering")
    end

    def rails_new_options
      ExampleType.rails_new_options
    end
  end
end
