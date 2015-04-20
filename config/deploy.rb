$LOAD_PATH << File.join(Dir.pwd, 'lib')

require 'capistrano/ext/multistage'
require 'bundler/capistrano'
require 'airbrake/capistrano'

# Enable RVM deployment
set :rvm_type, :system
set :rvm_ruby_string, 'ruby-2.1.0@pressmatrix-exceptions'
require 'rvm/capistrano'

set :stages,                %w(staging production)
set :default_stage,         'staging'

set :application,           'exceptions'
set :repository,            'https://PmxImDeployment:GN1pGpi2kXYr@github.com/pressmatrix/errbit.git'
set :scm,                   :git
set :use_sudo,              false
ssh_options[:paranoid] =    false
set :user,                  'deploy'

set :deploy_via,            :remote_cache
set :deploy_to,             "/var/www/#{application}.pressmatrix.com"
set :rails_root,            '/var/www/#{application}.pressmatrix.com/current'
set :rack_env,              defer { rails_env }

# Uncomment for cron jobs
# set :whenever_command,      'bundle exec whenever'
# set :whenever_environment,  defer { stage }
# set :whenever_identifier,   defer { "#{application}_#{stage}" }
# set :whenever_roles,        [:whenever]
# require 'whenever/capistrano'

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}", :shell => '/bin/bash'
  end

  namespace :settings do
    task :symlink, except: { no_release: true } do
      run "ln -nfs #{shared_path}/config/settings.local.yml #{release_path}/config/settings.local.yml" 
    end
  end
end

after 'deploy:finalize_update', 'deploy:settings:symlink'

namespace :errbit do
  desc "Setup config files (first time setup)"
  task :setup do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      execute "mkdir -p #{shared_path}/pids"
      execute "touch #{shared_path}/.env"
    end
  end
end

namespace :db do
  desc "Create and setup the mongo db"
  task :setup do
    on roles(:db) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'errbit:bootstrap'
        end
      end
    end
  end
end