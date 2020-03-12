before "deploy:assets:precompile", "deploy:yarn_install"

namespace :deploy do
  desc 'Run rake yarn:install'
  task :yarn_install do
    on roles(:web) do
      within release_path do
        execute("cd #{release_path} && yarn install")
      end
    end
  end
end

# config valid for current version and patch releases of Capistrano
lock "~> 3.12.1"
# set :rvm_type, :user
# set :rvm_ruby_version, '2.6.3'

set :application, "ekt_library"
set :repo_url, "git@github.com:iL53n/ekt_library.git"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/gribko/ekt_library"
set :deploy_user, "gribko"

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/master.key"


# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "storage"