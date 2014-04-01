clinton = User.create!(first_name: 'Clinton', last_name: 'Blackburn', username: 'ccb621', email: 'clinton@clintonblackburn.com', password: 'password', password_confirmation: 'password')
Challenge.create([{description: 'Photograph an interesting cloud.', user: clinton}, {description: 'Photograph someone on the street.', user: clinton}])


users = 20.times.collect { User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, username: Faker::Internet.user_name, email: Faker::Internet.email, password: 'password', password_confirmation: 'password') }
users.each do |user|
  Challenge.create!(rand(10).times.collect{ {description: Faker::Lorem.sentence, user: user} })
end

400.times.collect {
  Photo.create(url: "http://lorempixel.com/640/480/?#{rand(10000)}", user: User.offset(rand(User.count)).first, challenges: [Challenge.offset(rand(Challenge.count)).first], data_source: DataSource.where(name: 'Twitter').first, data_source_external_id: Faker::Number.number(10))
}


5.times.collect {
  date = Time.now.midnight - (DailyChallenge.count).days
  DailyChallenge.create(challenge: Challenge.offset(rand(Challenge.count)).first, created_at: date, updated_at: date)
}
