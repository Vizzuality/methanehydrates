role :app, linode_staging
role :web, linode_staging
role :db,  linode_staging, :primary => true

set :user,  'ubuntu'
set :scm_user, 'ubuntu'

set :deploy_to, "/home/ubuntu/www/#{application}"

set :branch, "staging"