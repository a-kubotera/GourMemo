def time_rand from = Time.local(0), to = Time.now
    Time.at(rand(from.to_f..to.to_f))
end

30.times do
  Faker::Config.locale = :ja
  @gimei = Gimei.new
  email = Faker::Internet.email
  name = @gimei.kanji
  age = rand(100)
  address = @gimei.prefecture.kanji + @gimei.city.kanji + @gimei.town.kanji
  profile = Faker::Lorem.sentence
  password = "password"
  #

  @user = User.create!(
    email:  email,
    name:   name,
    age:    age,
    addless:address,
    profile:profile,
    password:password
    #birth: Faker::Date.birthday(18, 65),
    #alive: [true, false].sample,
  )

  @a_gimei = Gimei.new
  a_name = Faker::Name.name
  a_address = @a_gimei.prefecture.kanji + @a_gimei.city.kanji + @a_gimei.town.kanji
  a_phone = Faker::PhoneNumber.cell_phone
  a_comment = Yoshida::Text.sentences(3)
  a_sorce = ["TVでみた","ネットでみた","雑誌で読んだ","たまたま通りかかった"].sample

  @art = Article.create!(
    name: a_name,
    address:a_address,
    tell:a_phone,
    art_comment:a_comment,
    source:a_sorce,
    user_id: @user.id
  )
  3.times do |n|
    e_date = time_rand Time.local(2015, 1, 1), Time.local(2017, 12, 31)
    e_evaluate = rand(5)
    e_comment =  Faker::Lorem.sentence
    @e_user =(1..30).to_a
    if n > 1
      e_user = @user.id

    else
      @e_user.delete(@user.id)
      e_user = @e_user.sample
    end
    Evaluate.create(
      date:e_date,
      evaluate:e_evaluate,
      eva_comment:e_comment,
      article_id:@art.id,
      user_id:e_user
    )
    n + 1
  end
end
