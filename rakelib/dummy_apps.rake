require_relative "task_helpers"
include ReactOnRails::TaskHelpers

namespace :dummy_apps do
  desc "Installs dummy apps' dependencies"
  task :install_dependencies do
    dummy_app_dirs.each do |dummy_app_dir|
      bundle_install_in(dummy_app_dir)
      dummy_app_client_dir = File.join(dummy_app_dir, "client")
      sh_in_dir(dummy_app_client_dir, "npm install
                                       $(npm bin)/webpack --config webpack.server.js
                                       $(npm bin)/webpack --config webpack.client.js")
    end
    # - cd spec/dummy && bundle install --gemfile=Gemfile
    # - cd client && npm install
    # - $(npm bin)/webpack --config webpack.server.js
    # - $(npm bin)/webpack --config webpack.client.js
    # - cd ../../dummy-react-013 && bundle install --gemfile=Gemfile
    # - cd client && npm install
    # - $(npm bin)/webpack --config webpack.server.js
    # - $(npm bin)/webpack --config webpack.client.js
    # - cd ../../../
  end
end

desc "Installs dummy apps' dependencies"
task dummy_apps: ["dummy_apps:install_dependencies"]
