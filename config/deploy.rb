# config valid only for current version of Capistrano
# capistranoのバージョンを記載。固定のバージョンを利用し続け、バージョン変更によるトラブルを防止する
lock '3.14.0'

# Capistranoのログの表示に利用する
set :application, 'chat-space'

# どのリポジトリからアプリをpullするかを指定する
set :repo_url,  'git@github.com:Harken101/chat-space.git'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.5.1' #カリキュラム通りに進めた場合、2.5.1か2.3.1です

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/ChatSpace.pem'] 

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
以下の5点は書き換えが必須です。

3行目のはご自身のバージョンを記述しましょう。
6行目の<自身のアプリケーション名>はご自身のものを記述しましょう。
9行目の/<レポジトリ名>も同様に、ご自身のもの記述してください。
15行目の<このアプリで使用しているrubyのバージョン>はご自身のものを確認して記述してください。
19行目の<ローカルPCのEC2インスタンスのSSH鍵(pem)へのパス>も同様に、ご自身のもの記述してください。
lock ＜Capistranoのバージョン＞'
capistranoのバージョンは、gemfile.lockに記載されています。以下のように書かれている場合は、3.11.0です。