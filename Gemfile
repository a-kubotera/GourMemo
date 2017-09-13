source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'
gem 'turbolinks'     #Railsのページ遷移高速化のためのgem
gem 'sdoc', group: :doc # Rubyのソースを読み取り、ブラウザで閲覧しやすいドキュメントを生成してくれる
#gem 'haml-rails' #hamlが使えるように

# UI/UX
gem 'jquery-rails'
gem 'coffee-rails'

gem 'font-awesome-rails' #アイコンタグを挿入するヘルパーメソッドを提供
gem 'uglifier' #JSのコード軽量化ライブラリ。UglifyJS2をrubyで使えるようにしたもの
gem 'sass-rails'
gem 'jbuilder'
gem 'wareki' #元号表示(平成や昭和など)に対応。案外使える

# Bootstrapの導入
gem 'bootstrap-sass'
gem "font-awesome-rails" #アイコンの使用

# TwitterBootstrapの導入　使うときは　rails g bootstrap:themed ○○○
# http://ruby-rails.hatenadiary.com/entry/20140801/1406818800
gem 'therubyracer' # javascript runtime。lessをコンパイルするために必要
gem 'less-rails' # Railsでlessを使えるようにする。Bootstrapがlessで書かれているため
gem 'twitter-bootstrap-rails' # Bootstrapの本体

# Bootstrapマテリアルデザインの導入
gem 'bootstrap-material-design'
gem 'material_icons'


# ユーザー機能
gem 'devise' #ユーザー機能導入
gem 'devise-i18n' #devise日本語化
gem 'devise-bootstrap-views' #Bootstrap化　rails g devise:views:bootstrap_templates　　http://qiita.com/guri3/items/8c414558085620999786
gem 'devise-i18n-views'
# gem 'bcrypt' #パスワード暗号化機能を提供してくれる。　本番に上げる際はコメントアウトを外す。

#OAuth
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'

#APIの使用
# gem 'activeresource'　#herを使うこととする。
gem 'her'

# 役割定義
gem 'cancancan' #役割別に出来ること、出来ないことを定義できる。

# 各種ファイル設定用
gem 'dotenv-rails' #ドットファイルの定義用
gem 'config' #定数定義用
gem 'enum_help' #enumの日本語化

# データベース
#gem 'mysql2', '~> 0.3.18' #mysql バージョン指定は適宜変更
gem 'pg'#postgresql

# seed用
gem 'seed-fu'
gem 'faker','~> 1.1.2'

# 検索機能
gem 'ransack'

# ページネーション
gem 'kaminari'

# パンくず
gem 'gretel'

# アップロード用
gem 'carrierwave'
gem 'mini_magick' #画像リサイズ用のgem
gem 'fog' #AWS S3用画像アップロード

#通知機能
gem 'pusher'

# フォーム
gem 'bootstrap_form'

# 論理削除
gem 'paranoia'

# Model拡張
gem 'active_hash'

# 管理画面　→　一旦保留とする　後日改めて使用
# gem 'adminlte2-rails'

# サーバー
gem 'unicorn'

group :development, :test do
  # デバック用
  gem 'byebug'
  gem 'better_errors'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'hirb'
  gem 'awesome_print'
  gem 'letter_opener_web' #メール送信機能をローカルで試すためのgem
  gem 'web-console', '~> 2.0'

  # CLI
  gem 'spring'

  # Table/Scheme
  gem 'annotate' #schemaをモデルに書き出してくれる

  # デプロイ
  gem 'capistrano', '3.6.0'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano3-unicorn'

  #テスト
  gem "rspec-rails"
  gem "factory_girl_rails" #テストデータの作成　http://qiita.com/9_tricks/items/f333a76bcf7f90f85144
end

#Herokuデプロイ用
gem 'rails_12factor', group: :production
