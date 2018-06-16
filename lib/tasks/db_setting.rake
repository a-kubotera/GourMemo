namespace :db do
  desc "DB作成からSeed_fuまでまとめて実行"

  task :setting, [] => :environment do
    raise "Not allowed to run on production" if Rails.env.production?
    Rake::Task['db:drop'].execute
    Rake::Task['db:create'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed_fu'].execute
  end
end
