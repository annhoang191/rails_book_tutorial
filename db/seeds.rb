User.create!(name: "Hoang Quynh Anh",
  email: "example@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "123456"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password)
end
