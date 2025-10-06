# config/deploy.rb
# config valid for current version and patch releases of Capistrano

set :application, "rem"
set :repo_url, "https://github.com/MPSD-Finance-sofft/Rem.git"

set :puma_threads,    [4, 16]
set :puma_workers,    0

append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "storage"
append :rbenv_map_bins, 'puma', 'pumactl'
set :linked_files, %w(config/database.yml)

set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       '/opt/apps/rem'  # Production složka
set :puma_bind,       "tcp://0.0.0.0:3000"
set :puma_state,      "#{shared_path}/tmp/pids/puma_production.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma_production.pid"
set :puma_access_log, "#{release_path}/log/puma_production.error.log"
set :puma_error_log,  "#{release_path}/log/puma_production.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, false
set :whenever_roles,  :app
set :whenever_environment, ->{ fetch(:rails_env) }
set :whenever_identifier,  ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

# Server definice
server '192.168.3.150', user: 'dep_rem', roles: %w{app db web}

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  before :starting, :check_revision
end
