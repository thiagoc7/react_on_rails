require_relative "task_helpers"
include ReactOnRails::TaskHelpers

namespace :ci do
  desc "Runs all tests and linting"
  task run: [:run_rspec, :lint]

  desc "Installs dependencies such as nvm and dummy app webpack bundles"
  task :install do
    # Install Node Version Manager and Node Version
    rm_rf("~/.nvm")
    sh_in_dir(".", "git clone https://github.com/creationix/nvm.git ~/.nvm")
    sh_in_dir("~/.nvm", "git checkout `git describe --abbrev=0 --tags`
                         source ~/.nvm/nvm.sh
                         nvm install #{node_version}")

    # Install Node Package Manager
    npm(".", "install -g npm")

    # Install Gem dependencies
    bundle_install_in(gem_root)

    # Install dependencies for dummy apps
    dummy_app_dirs.each do |dummy_app_dir|
      dummy_app_dir = File.join(gem_root, dummy_app_dir)
      bundle_install_in(dummy_app_dir)
      shell_commands = "npm install
                        $(npm bin)/webpack --config webpack.server.js
                        $(npm bin)/webpack --config webpack.client.js"
      dummy_app_client_dir = File.join(dummy_app_dir, "client")
      sh_in_dir(dummy_app_client_dir, shell_commands)
    end
  end
end
