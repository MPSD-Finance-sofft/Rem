# config/deploy/production_circolus.rb
set :stage, :production_circolus
set :puma_bind, "tcp://0.0.0.0:4000"
set :puma_state, "#{shared_path}/tmp/pids/puma_circolus.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma_circolus.pid"
set :puma_access_log, "#{release_path}/log/puma_circolus.error.log"
set :puma_error_log, "#{release_path}/log/puma_circolus.access.log"
