require_relative "task_helpers"
include ReactOnRails::TaskHelpers

namespace :dummy_apps do
  task :install_dummy_app do
    dummy_app_dir = File.join(gem_root, "spec/dummy")
    bundle_install_in(dummy_app_dir)
    dummy_app_client_dir = File.join(dummy_app_dir, "client")
    sh_in_dir(dummy_app_client_dir, "npm install
                                     $(npm bin)/webpack --config webpack.server.js
                                     $(npm bin)/webpack --config webpack.client.js")
  end

  task :install_dummy_react_013_app do
    dummy_app_dir = File.join(gem_root, "spec/dummy-react-013")
    bundle_install_in(dummy_app_dir)
    dummy_app_client_dir = File.join(dummy_app_dir, "client")
    sh_in_dir(dummy_app_client_dir, "npm install
                                     $(npm bin)/webpack --config webpack.server.js
                                     $(npm bin)/webpack --config webpack.client.js")
  end
end

