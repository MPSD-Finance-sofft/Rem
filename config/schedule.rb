# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
set :chronic_options, hours24: true
set :environment, ENV['RAILS_ENV']
set :output, "#{path}/log/cron.log"
set :bundle_command, 'bundle exec'
job_type :runner, "cd :path && :bundle_command rails runner -e :environment ':task' :output"

job_type :rbenv_runer, %Q{export PATH=/home/dep_rem/.rbenv/shims:/home/dep_rem/.rbenv/bin:/usr/bin:$PATH; eval "$(rbenv init -)"; \
	cd :path && :bundle_command :runner_command -e :environment ':task' :output }
# every 1.minute do
# 	runner "User::nevim", :environment => 'production'
# end
# Learn more: http://github.com/javan/whenever
every 1.hour do
	rbenv_runer "Client::duplicate_clients", :environment => 'production'
end

every 1.hour do
	rbenv_runer "RepaymentPayment::remove_ussles", :environment => 'production'
end

every 1.hour do
	rbenv_runer "LeasingContract::recalculation_payments", :environment => 'production'
end

every 1.hour do
	rbenv_runer "LeasingContract::change_state", :environment => 'production'
end

every 24.hour do
	rbenv_runer "Activity::delete_duplicate", :environment => 'production'
end

every 24.hour do
	rbenv_runer "User::downalod_data_from_ares", :environment => 'production'
end

every 24.hour do
	rbenv_runer "User::company_name_from_ares", :environment => 'production'
end

every 24.hour do
	#rbenv_runer "Address::synthesis_address", :environment => 'production'
end

every 24.hour do
	rbenv_runer "Accord::automatic_add_energy_task", :environment => 'production'
end

every 24.hour do
	rbenv_runer "Accord::automatic_add_month_advances", :environment => 'production'
end

every 24.hour do
	rbenv_runer "Event::create_birthday", :environment => 'production'
end
