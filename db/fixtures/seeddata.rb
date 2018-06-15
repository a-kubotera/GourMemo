# #テストデータをすべて削除
Like.delete_all
Relationship.delete_all
User.delete_all
Article.delete_all
Evaluate.delete_all
# 初期設定
Faker::Config.locale = :ja

def time_rand from = Time.local(0), to = Time.now
  Time.at(rand(from.to_f..to.to_f))
end

# 1. 10人のユーザーを作る
# 2. 各ユーザーが2件の記事を投稿する
# 3. 投稿した記事を評価する
# 4. 10人それぞれ自分以外の人の記事を3つイイねする
# 5. いいねした記事を評価する

1000.step(1010,1) { |n|

  # 1. ユーザー用ダミーデータ作成
  @gimei = Gimei.new 
  uid = n
  name = @gimei.kanji
  email = Faker::Internet.email
  address = @gimei.prefecture.kanji + @gimei.city.kanji + @gimei.town.kanji
  age = rand(100)
  profile = Faker::Lorem.sentence
  password = "password"
  provider = "provider"
  # Userを作成
  user = User.new(
    id: uid,name: name, email: email, age: age, uid: uid,
    address: address, profile: profile, password: password, provider: provider
  )
  user.skip_confirmation! # メール送信をスキップ
  user.save!
  # 2. 記事を2件書く
  1.step(2,1){ |m|
    @gimei = Gimei.new
    aid = Article.count + 1
    title = "#{["レストラン", "ラーメン", "蕎麦処", "定食屋", "居酒屋"].sample} #{@gimei.name.first} #{@gimei.town.kanji}店"
    address = @gimei.prefecture.kanji + @gimei.city.kanji + @gimei.town.kanji
    phone = Faker::PhoneNumber.cell_phone
    comment = ["雰囲気の良いお店", "最近できたお店", "知る人ぞ知る名店!!", "地元では評判のお店", "一度は行ってみたい！", "近くに行ったときは是非行きたい!"].sample
    station = "#{@gimei.town.kanji}駅"
    sorce = ["TVでみた","ネットでみた","雑誌で読んだ","たまたま通りかかった"].sample
    Article.seed(
      id: aid, name: title, address: address, tell: phone, station: station,
      art_comment:comment, source:sorce, user_id: uid
    )
  }
  # 3. 書いた記事のうちの1つを評価する
  eid = Evaluate.count + 1
  date = time_rand Time.local(2017, 1, 1), Time.local(2018, 6, 11)
  evaluate = [["期待はずれ・・・",1],["イマイチ・・",2],["まぁまぁ",3],["良かった！",4],["すごく良かった！",5]].sample
  Evaluate.seed(id: eid, date: date, evaluate: evaluate[1], eva_comment: evaluate[0], user_id: user.id, article_id: user.articles.first.id )
} 

# 4. 10人それぞれ自分以外の人の記事を3つイイねする
1000.step(1010,1) { |n|
  current_user = User.find(n)
  user_ids = User.ids
  user_ids.delete(n)

  3.times do
    num = user_ids.sample
    user_ids.delete(num)
    article_id = User.find(num).articles.sample.id
    Like.seed(
      id: Like.count + 1, 
      article_id: article_id,
      user_id: current_user.id
    )
    # 5. イイねした記事を評価する
    eid = Evaluate.count + 1
    date = time_rand Time.local(2017, 1, 1), Time.local(2018, 6, 11)
    evaluate = [["期待はずれ・・・",1],["イマイチ・・",2],["まぁまぁ",3],["良かった！",4],["すごく良かった！",5]].sample
    Evaluate.seed(id: eid, date: date, evaluate: evaluate[1], eva_comment: evaluate[0], user_id: current_user.id, article_id: article_id) 
  end
}
