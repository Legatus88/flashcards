lock '3.11.0'
# Название приложения
set :application, 'flashcards'
# Путь к git репозиторию
set :repo_url, 'git@github.com:Legatus88/flashcards.git'
# Ветка по-умолчанию
set :branch, '20th-task'
# Директория для деплоя
set :deploy_to, '/home/ubuntu/applications/flashcards'

set :log_level, :info
# Копирующиеся файлы и директории (между деплоями)
set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}

# Ruby свистелки
set :rbenv_type, :user
set :rbenv_ruby, '2.5.1'
set :rbenv_path, '/home/ubuntu/.rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_roles, :all

# А это рекомендуют добавить для приложений, использующих ActiveRecord
set :puma_init_active_record, true

desc 'Run rake tasks on server'
task :rake do 
  on roles(:app), in: :sequence, wait: 5 do
  	within release_path do
  	  with rails_env: :production do
  	  	execute :rake, ENV['task'], 'RAILS_ENV=production'
  	  end
  	end
  end
end