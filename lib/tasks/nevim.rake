namespace :nevim do
  task :nevim => :environment do
  		u = User.first
  		u.name = Time.now
  		u.save(validate:false)	
  end
end