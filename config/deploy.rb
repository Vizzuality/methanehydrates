require 'capistrano/ext/multistage'
require 'config/boot'
require "bundler/capistrano"

set :stages, %w(staging production)
set :default_stage, "production"

default_run_options[:pty] = true

set :application, 'methane'

set :scm, :git
set :git_shallow_clone, 1
set :scm_user, 'ubuntu'
set :repository, "git://github.com/Vizzuality/methanehydrates.git"
ssh_options[:forward_agent] = true
set :keep_releases, 5

set :linode_staging, '178.79.131.104'
set :linode_production, '178.79.142.149'
set :user,  'ubuntu'

set :deploy_to, "/home/ubuntu/www/#{application}"

# set :bundle_flags,       "--deployment --quiet"

after  "deploy:update_code", :run_migrations, :symlinks

desc "Restart Application"
deploy.task :restart, :roles => [:app] do
  run "touch #{current_path}/tmp/restart.txt"
end

desc "Migraciones"
task :run_migrations, :roles => [:app] do
  run <<-CMD
    export RAILS_ENV=production &&
    cd #{release_path} &&
    rake db:migrate
  CMD
end

task :symlinks, :roles => [:app] do
  run <<-CMD
    ln -s #{shared_path}/system #{release_path}/public/system;
  CMD
end