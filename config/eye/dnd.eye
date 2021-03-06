BUNDLE = 'bundle'
RAILS_ENV = 'production'
ROOT = File.expand_path(File.join(File.dirname(__FILE__), %w[ processes ]))
RAILS_ROOT = File.expand_path(File.dirname(__FILE__) + "../../..")

Eye.config do
  logger "#{ROOT}/eye.log"
end

Eye.application :dnd do
  env 'RAILS_ENV' => RAILS_ENV
  working_dir RAILS_ROOT
  trigger :flapping, :times => 10, :within => 1.minute

  process :puma do
    daemonize true
    pid_file "puma.pid"
    stdall "log/puma.log"

    start_command "#{BUNDLE} exec puma -b unix://#{RAILS_ROOT}/tmp/sockets/puma.sock --environment #{RAILS_ENV} #{RAILS_ROOT}/config.ru"
    stop_signals [:TERM, 5.seconds, :KILL]
    restart_command "kill -USR2 {{PID}}"

    restart_grace 10.seconds # just sleep this until process get up status
                             # (maybe enought to puma soft restart)

    check :cpu, :every => 30, :below => 80, :times => 3
    check :memory, :every => 30, :below => 70.megabytes, :times => [3,5]
  end

  process :faye do
    daemonize true
    pid_file "faye.pid"
    stdall "log/faye.log"

    start_command "#{BUNDLE} exec rackup #{RAILS_ROOT}/faye.ru -s thin -E production -p 9295"
    stop_signals [:TERM, 5.seconds, :KILL]
    restart_command "kill -USR2 {{PID}}"

    restart_grace 10.seconds # just sleep this until process get up status
                             # (maybe enought to puma soft restart)

    check :cpu, :every => 30, :below => 80, :times => 3
    check :memory, :every => 30, :below => 70.megabytes, :times => [3,5]
  end

end