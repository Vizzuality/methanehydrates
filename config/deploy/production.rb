role :app, linode_production
role :web, linode_production
role :db,  linode_production, :primary => true

set :user,  'admin'
set :scm_user, 'admin'

set :deploy_to, "/Library/WebServer/Documents/#{application}"

set :branch, "production"
