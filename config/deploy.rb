

### USING THIS GUIDE https://github.com/capistrano/capistrano/wiki/2.x-From-The-Beginning
 set :deploy_to, "/srv/www/swEng/reminder/"
 #set :user, "sweng"
 set :use_sudo, true
# ssh_options[:forward_agent] = true



#if [ -d /srv/www/swEng/shared/cached-copy ]; then cd /srv/www/swEng/shared/cached-copy && git fetch -q origin && git fetch --tags -q origin && git reset -q --hard 25609f0b03b924916631174cf61951679ca8e58e && git clean -q -d -x -f; else git clone -q  ssh://git@kater.homelinux.org:23/reminder /srv/www/swEng/shared/cached-copy && cd /srv/www/swEng/shared/cached-copy && git checkout -q -b deploy 25609f0b03b924916631174cf61951679ca8e58e; fi

default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :repository, "git@github.com:TehSeriousBusiness/reminder.git"  # Your clone URL
set :scm, "git"
set :user, "sweng"  # The server's user for deploys
#set :scm_passphrase, "p@ssw0rd"  # The deploy user's password
ssh_options[:forward_agent] = false
set :branch, "master"
set :scm_verbose, true
set :deploy_via, :remote_cache

ssh_options[:port] = 23


#
# WHAT UP?
#


# set :application, "Reminder"
# set :repository,  "ssh://git@kater.homelinux.org:23/reminder"

# set :scm, :git
#Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#use this branch as the basis for deployment
# set :branch, "devD_Capistrano"

#use this if you do NOT want to clone the complete repo every time the App is deployed
# set :deploy_via, :remote_cache


 set :domain, "kater.homelinux.org"

 role :web, "#{domain}"                          # Your HTTP server, Apache/etc
 role :app, "#{domain}"                          # This may be the same as your `Web` server
 role :db,  "#{domain}", :primary => true # This is where Rails migrations will run

#if you're still using the script/reaper helper you will need
#these http://github.com/rails/irs_process_scripts

#If you are using Passenger mod_rails uncomment this:
#namespace :deploy do
#  task :start do ; end
 # task :stop do ; end
 # task :restart, :roles => :app, :except => { :no_release => true } do
 #   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
 # end
#end

namespace :deploy do
	desc "kills and restarts the server"
	task :restart do 
		#run "killall -9 ruby18"				## finds the process_ID and kills the processes
		run "killall -9 ruby18;true"	
		run "cd #{current_path} && rails server -p 6666 -d"												## switching to the current dir and starting the rails server
		run "cd #{current_path}; ruby script/delayed_job restart"
		run "touch #{current_path}/tmp/restarted"								## set a timestamp at the file restarted
	end
	
	desc "bundle install"
	task :bundle do 
		run "cd #{current_path} && #{try_sudo} bundle install"	## installs all required bundles
	end
	
	desc "Set Symlink to Shared/DB/..."
	task :database do
		run "rm #{release_path}/db/development.sqlite3;true"
		run "ln -nsf #{shared_path}/db/development.sqlite3 #{release_path}/db/development.sqlite3"
	end
end

after 'deploy:update_code', 'deploy:database'