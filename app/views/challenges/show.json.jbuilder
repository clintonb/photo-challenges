json.extract! @challenge, :id, :created_at, :description, :daily_challenge_date
json.user do
  json.partial! 'users/user', user: @challenge.user
end
json.photos do
  json.count @challenge.photos.count
  json.links do
    json.array!(@challenge.photos) do |photo|
      json.extract! photo, :id, :url
      json.user do
        json.partial! 'users/user', user: photo.user
      end
    end
  end
end
