namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Devang gupta",
                         email: "devangtgr8@gmail.com",
                         password: "foobar123",
                         password_confirmation: "foobar123",
                         admin: :true)
     User.create!(name: "Shivam Satija",
                         email: "shivamsatija04@gmail.com",
                         password: "foobar123",
                         password_confirmation: "foobar123",
                         admin: :true)
    99.times do |n|
    name  = Faker::Name.name
    email = Faker::Internet.email
    password  = "password123"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
    end

    99.times do |n|
      author = Faker::Name.name
      title = "Rails-#{n+1}"
      isbn = 1234567891234
    Book.create!(title: title,
                        isbn: isbn,
                        author: author)
    end

  end
end