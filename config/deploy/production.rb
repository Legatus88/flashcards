ip = '18.217.27.240'

role :app, ["ubuntu@#{ip}"]
role :web, ["ubuntu@#{ip}"]
role :db,  ["ubuntu@#{ip}"]

server ip, user: 'ubuntu', roles: %w{app db web}

set :stage, 'production'
set :rails_env, 'production'