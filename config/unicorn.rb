worker_processes 2
working_directory "/home/anime/deploy_sample/current" #appと同じ階層を指定

timeout 3600


listen "/var/run/unicorn/Nginxで設定した名前.sock"
pid "/var/run/unicorn/Nginxで設定した名前.pid"


stderr_path "/home/anime/deploy_sample/current/log/unicorn.log"
stdout_path "/home/anime/deploy_sample/current/log/unicorn.log"


preload_app true