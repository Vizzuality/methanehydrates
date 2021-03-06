require 'capistrano/ext/multistage'
require 'config/boot'
require "bundler/capistrano"

set :stages, %w(staging production)
set :default_stage, "production"

default_run_options[:pty] = true

set :application, 'methane'

set :scm, :git
set :git_shallow_clone, 1
set :repository, "git://github.com/Vizzuality/methanehydrates.git"
ssh_options[:forward_agent] = true
set :keep_releases, 5

set :linode_staging, '178.79.131.104'
set :linode_production, '82.116.78.184'

after "deploy:update_code", :symlinks, :asset_packages
after "deploy", "deploy:cleanup"

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
    ln -s #{shared_path}/dragonfly #{release_path}/tmp/
  CMD
  run <<-CMD
    ln -s #{shared_path}/config/app_config.yml #{release_path}/config/app_config.yml
  CMD
end

desc 'Create asset packages'
task :asset_packages, :roles => [:app] do
 run <<-CMD
   export RAILS_ENV=production &&
   cd #{release_path} &&
   rake asset:packager:build_all
 CMD
end
