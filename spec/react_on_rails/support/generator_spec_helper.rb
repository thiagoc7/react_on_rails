require "react_on_rails/simplecov_helper"
require "generator_spec" # let's us use Rails's generator testing helpers but with RSpec syntax
Dir[File.expand_path("../../support/shared_examples", __FILE__) + "/*.rb"].each { |file| require file }
generators_glob = File.expand_path("../../../../lib/generators/react_on_rails/*_generator.rb", __FILE__)
Dir[generators_glob.to_s].each { |file| require file }
include ReactOnRails::Generators

# Expects an array of strings, such as "--redux"
def run_generator_test_with_args(args, options = {})
  prepare_destination # this completely wipes the `destination` directory
  simulate_existing_file(".gitignore")
  simulate_existing_file("Gemfile", "CoffeeScript\ncoffee-rails\n")
  simulate_existing_file("config/routes.rb", "Rails.application.routes.draw do\nend\n")
  simulate_existing_file("config/application.rb", "module Gentest\nclass Application < Rails::Application\nend\nend)")
  simulate_existing_file("config/initializers/assets.rb")
  app_js_data = <<-DATA.strip_heredoc
    //= require jquery
    //= require jquery_ujs
    //= require turbolinks
    //= require_tree .
  DATA
  simulate_existing_file("app/assets/javascripts/application.js", app_js_data)
  application_css = "app/assets/stylesheets/application.css.scss"
  if options.fetch(:application_css, true)
    simulate_existing_file(application_css, " *= require_tree .\n *= require_self\n")
  end
  run_generator(args)
end

def assert_server_render_procfile
  assert_file "Procfile.dev" do |contents|
    assert_match(/\n\s*server:/, contents)
  end
end

def assert_client_render_procfile
  assert_file "Procfile.dev" do |contents|
    refute_match(/\n\s*server:/, contents)
  end
end

# Simulate having an existing file for cases where the generator needs to modify, not create, a file
def simulate_existing_file(file, data = "some existing text\n")
  path = Pathname.new(File.join(destination_root, file))
  mkdir_p(path.dirname)
  File.open(path, "w+") do |f|
    f.puts(data) if data.presence
  end
end

# Simulate having an existing directory for cases where the generator needs to add a file to a directory
# that will definitely already exist
def simulate_existing_dir(dirname)
  path = File.join(destination_root, dirname)
  mkdir_p(path)
end

def assert_directory_with_keep_file(dir)
  assert_directory dir
  assert_file File.join(dir, ".keep")
end
