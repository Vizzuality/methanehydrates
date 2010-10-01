# Methane Gas Hydrates

A project based on [Geoportal](http://github.com/vizzuality/geoportal)

## Start using it

    rvm use 1.8.7
    rvm gemset create methanehydrates
    rvm use 1.8.7@methanehydrates
    gem install bundler
    git clone git@github.com:Vizzuality/methanehydrates.git
    cd methanehydrates
    bundle install
    rake db:setup
    rails s

Visit `http://localhost:3000/admin` in your browser (by default it creates an administrator user with login `admin` and password `admin`).
