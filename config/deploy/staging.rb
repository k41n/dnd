role :web, 'dd.kodep.ru'
role :app, 'dd.kodep.ru'
role :db,  'dd.kodep.ru'

namespace :deploy do
  task :copy_eye_config do
    run "cp #{release_path}/config/eye/dnd.eye.staging #{release_path}/config/eye/dnd.eye"
  end
end