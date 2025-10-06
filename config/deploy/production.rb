# config/deploy/production.rb
set :stage, :production
set :puma_bind, "tcp://0.0.0.0:3000"
set :puma_state, "#{shared_path}/tmp/pids/puma_production.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma_production.pid"
set :puma_access_log, "#{release_path}/log/puma_production.error.log"
set :puma_error_log, "#{release_path}/log/puma_production.access.log"
