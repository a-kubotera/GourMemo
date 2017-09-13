100.times do
  Faker::Config.locale = :ja
  User.create(
    email:  Faker::Internet.email,
    name:   Faker::Name.name,
    age:    Faker::Number.between(1, 100),
    addless:Faker::Addless.name,
    #birth: Faker::Date.birthday(18, 65),
    #alive: [true, false].sample,
    profile: Faker::Lorem.sentence
  )
end
