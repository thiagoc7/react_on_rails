require_relative "task_helpers"
include ReactOnRails::TaskHelpers

task ci: [:run_rspec, :lint]
# do

  # Rake::Task["run_rspec:gem"].invoke
  # Rake::Task["dummy_apps:install_dummy_app"].invoke
  # Rake::Task["run_rspec:dummy"].invoke
  # Rake::Task["dummy_apps:install_dummy_react_013_app"].invoke
  # Rake::Task["run_rspec:dummy_react_013"].invoke
  # Rake::Task["examples:gen_basic"].invoke
  # Rake::Task["run_rspec:example_basic"].invoke
  # Rake::Task["examples:gen_basic_server_rendering"].invoke
  # Rake::Task["run_rspec:example_basic_server_rendering"].invoke
  # Rake::Task["examples:gen_redux"].invoke
  # Rake::Task["run_rspec:example_redux"].invoke
  # Rake::Task["examples:gen_redux_server_rendering"].invoke
  # Rake::Task["run_rspec:example_redux_server_rendering"].invoke
# end
