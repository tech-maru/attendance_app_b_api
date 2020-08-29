# coding: utf-8

User.create!(name: "Admin User",
             email: "sample1@email.com",
             password: "sample1@email.com",
             password_confirmation: "sample1@email.com",
             admin: "true")

10.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+2}@email.com"
  password = "sample-#{n+2}@email.com"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               admin: "false")
               
end

puts "CREATE 10USER"
               
# attendance

user = User.find(2)

typeA = ["02", "04", "06", "10", "12"]
typeB = ["01", "03", "05", "07", "09", "11", "15"]

typeB.each do |number|
  user.attendances.create!(
    worked_on: "2020-08-#{number}",
    started_at: "2020-08-#{number} 10:00:00",
    finished_at: "2020-08-#{number} 18:00:00",
  )
end

typeA.each do |number|
  user.attendances.create!(
    worked_on: "2020-07-#{number}",
    started_at: "2020-07-#{number} 10:00:00",
    finished_at: "2020-07-#{number} 18:00:00",
  )
end

