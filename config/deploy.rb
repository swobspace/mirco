# config valid for current version and patch releases of Capistrano
lock '~> 3.16.0'

config = YAML.load_file('config/deploy-config.yml') || {}

set :application, 'mirco'
set :repo_url, config['repo_url']
set :relative_url_root, config['relative_url_root'] || '/'
set :ruby_path, config['ruby_path']
set :passenger_restart_with_touch, true

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
ask :branch, :master

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
set :deploy_to, config['deploy_to']

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

append :linked_files, 'config/database.yml', 'config/mirco.yml', 'config/secrets.yml', 'config/Passengerfile.json',
       'tmp/restart.txt'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

append :linked_dirs, 'log', 'files', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system',
       'node_modules', 'config/credentials'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :default_env, {
  rails_relative_url_root: fetch(:relative_url_root),
  path: fetch(:ruby_path) { '$PATH' }
}

set :shell, 'bash -l'

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :ssh_options, verify_host_key: :secure

namespace :check do
  desc 'Check that we can access everything'
  task :check_write_permissions do
    on roles(:all) do |host|
      if test("[ -w #{fetch(:deploy_to)} ]")
        info "#{fetch(:deploy_to)} is writable on #{host}"
      else
        error "#{fetch(:deploy_to)} is not writable on #{host}"
      end
    end
  end
  desc 'check configuration and installation'
  task :configinstall do
    on roles(:app, :web) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'installation:all'
        end
      end
    end
  end
end

namespace :deploy do
  desc 'printenv'
  task :printenv do
    on roles(:all) do |_host|
      execute 'printenv'
    end
  end

  desc 'reload the database with seed data'
  task :seed do
    on primary :db do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end
end
