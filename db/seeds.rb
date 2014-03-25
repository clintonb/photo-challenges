clinton = User.create!(first_name: 'Clinton', last_name: 'Blackburn', email: 'clinton@clintonblackburn.com', password: 'password', password_confirmation: 'password')
Challenge.create([{description: 'Photograph an interesting cloud.', user: clinton}, {description: 'Photograph someone on the street.', user: clinton}])


users = 20.times.collect { User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'password', password_confirmation: 'password') }
users.each do |user|
  Challenge.create!(rand(10).times.collect{ {description: Faker::Lorem.sentence, user: user} })
end

400.times.collect {
  Photo.create!(url: 'http://lorempixel.com/640/480/', user: User.offset(rand(User.count)).first, challenge: Challenge.offset(rand(Challenge.count)).first)
}
