100.times do
  User.create(email: Faker::Internet.email, password: "password")
end

1000.times do
  User.find(rand(1..100)).posts.create(body: Faker::Hacker.say_something_smart)
end
