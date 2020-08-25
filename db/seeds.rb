# coding: utf-8

User.create!(name: "Admin User",
             email: "sample1@email.com",
             password: "sample1@email.com",
             password_confirmation: "sample1@email.com",
             admin: "true")

60.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+2}@email.com"
  password = "sample-#{n+2}@email.com"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               admin: "false")
end