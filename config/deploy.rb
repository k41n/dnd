ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :application, 'dnd'
set :deploy_to, '/var/www/railsapps/dnd'
set :depoly_via, :remote_cache
set :keep_releases, 5

set :scm, :git
set :repository,  'git@github.com:k41n/dnd.git'
set :normalize_asset_timestamps, false

set :user, 'railrunner'
set :use_sudo, false
set :files_owner, 'railrunner'
set :files_group, 'railrunner'

set :migrate_env, 'RAILS_ENV=production'

set :db_host, '127.0.0.1'
set :db_name, 'dnd_production'
set :db_user, 'railrunner'
set :db_pass, 'hul5OP6DaK6a'

# Load RVM's capistrano plugin.
require 'rvm/capistrano'

set :rvm_ruby_string, '2.1.1@dnd'
set :rvm_type, :user

depend :remote, :command, 'git'
depend :remote, :gem, 'bundler'
depend :remote, :directory, '/var/www/railsapps/dnd'

after 'deploy:update_code', :generate_database_yml
after 'deploy:update_code', 'deploy:migrate'
after 'deploy:update_code', :setup_symlinks
after 'deploy:update_code', :build_assets
after 'deploy',             'deploy:cleanup'
before 'deploy', :create_dirs
before 'deploy:restart', 'deploy:copy_eye_config'

desc <<-DESC
  Generates database.yml
DESC
task :generate_database_yml, :roles => :app do
  template = File.read('config/database.yml.erb')
  file_path = File.join(release_path, 'config', 'database.yml')
  conf = ERB.new(template).result(binding)
  put(conf, file_path)
end
task :build_assets, :roles => :app do
  run "cd #{release_path} && rake RAILS_ENV=production assets:precompile"
end

task :setup_symlinks, :roles => :app do
  run "mkdir -p #{shared_path}/reports && mkdir -p #{shared_path}/sockets && mkdir -p #{release_path}/tmp"
  run "ln -nfs #{shared_path}/sockets #{release_path}/tmp/sockets"
  run "ln -nfs #{shared_path}/system #{release_path}/system"
  run "ln -nfs #{shared_path}/log #{release_path}/log"
  run "ln -nfs #{shared_path}/pids #{release_path}/tmp/pids"
  run "ln -nfs #{shared_path}/projects #{release_path}/projects"
end

task :create_dirs, :roles => :app do
  run "mkdir -p #{shared_path}"
  run "mkdir -p #{deploy_to}/var"
  run "mkdir -p #{shared_path}/log"
  run "mkdir -p #{shared_path}/system"
  run "mkdir -p #{shared_path}/pids"
  run "mkdir -p #{shared_path}/projects"
end

namespace :deploy do
  desc <<-DESC
    Migrates DB from PRIMARY app server (must be set). Used \
    when project code is not deployed to DB serv. \
    P.S. It`s same task as default capistrano, only :roles is changed.
  DESC
  task :migrate do
    rake = fetch(:rake, 'rake')
    rails_env = fetch(:rails_env, 'production')
    migrate_env = fetch(:migrate_env, '')
    migrate_target = fetch(:migrate_target, :latest)

    directory = case migrate_target.to_sym
      when :current then current_path
      when :latest  then current_release
      else raise ArgumentError, "unknown migration target #{migrate_target.inspect}"
    end
    run "cd #{directory}; bundle install"
    run "cd #{directory}; #{rake} RAILS_ENV=#{rails_env} #{migrate_env} db:migrate"
  end

  desc <<-DESC
    Start the application servers.
  DESC
  task :start, :roles => :app do
    prefix = "source ~#{user}/.rvm/scripts/rvm; cd #{current_path}; RAILS_ENV=production rvm #{rvm_ruby_string} do eye "
    run "#{prefix} quit"
    run "#{prefix} load config/eye"
    run "#{prefix} start #{application}"
  end

  desc <<-DESC
    Restart the application servers.
  DESC
  task :restart, :roles => :app do
    prefix = "source ~#{user}/.rvm/scripts/rvm; cd #{current_path}; RAILS_ENV=production rvm #{rvm_ruby_string} do eye "
    run "#{prefix} stop #{application}"
    run "#{prefix} unmonitor #{application}"
    run "#{prefix} quit"
    run "#{prefix} load config/eye"
    run "#{prefix} start #{application}"
  end

  desc <<-DESC
    Stop the application servers.
  DESC
  task :stop, :roles => :app do
    prefix = "source ~#{user}/.rvm/scripts/rvm; cd #{current_path}; RAILS_ENV=production rvm #{rvm_ruby_string} do eye "
    run "#{prefix} stop #{application}"
    run "#{prefix} quit"
  end

  task :info, :roles => :app do
    prefix = "source ~#{user}/.rvm/scripts/rvm; cd #{current_path}; RAILS_ENV=production rvm #{rvm_ruby_string} do eye "
    run "#{prefix} info #{application}"
  end

  desc 'Loads database dump from staging'
  task :pull_db do
    `rm -f dnd.dump`
    prefix = "source ~#{user}/.rvm/scripts/rvm; cd #{current_path}; rvm #{rvm_ruby_string} do eye "
    run "#{prefix} stop #{application}"

    run "pg_dump -O -x -Fc #{db_name} -Z9 > /tmp/dnd.dump"
    get '/tmp/dnd.dump', 'dnd.dump'
    File.open 'config/database.yml' do |file|
      yaml = YAML.load(file.read)
      dc = yaml['development']
      dc ||= yaml['production']
      `dropdb #{dc['database']}`
      `createdb #{dc['database']}`
      `pg_restore -O -d #{dc['database']} dnd.dump`
      `rm -f dnd.dump`
    end

    prefix = "source ~#{user}/.rvm/scripts/rvm; cd #{current_path}; rvm #{rvm_ruby_string} do eye "
    run "#{prefix} start #{application}"

  end

  desc 'Synchronize images to staging'
  task :pull_images do
    `rsync -rL railrunner@dd.kodep.ru:/var/www/railsapps/dnd/current/public/system public/`
  end


end
