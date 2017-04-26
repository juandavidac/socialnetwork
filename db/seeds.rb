# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(username: "jd1", email: "jd1@mail.com", password: "123456", password_confirmation: "123456")
User.create(username: "jd2", email: "jd2@mail.com", password: "123456", password_confirmation: "123456")
User.create(username: "jd3", email: "jd3@mail.com", password: "123456", password_confirmation: "123456")
User.create(username: "jd4", email: "jd4@mail.com", password: "123456", password_confirmation: "123456")
User.create(username: "jd5", email: "jd15@mail.com", password: "123456", password_confirmation: "123456")
p "Test users created"
