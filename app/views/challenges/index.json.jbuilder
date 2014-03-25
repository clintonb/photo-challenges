json.array!(@challenges) do |challenge|
  json.extract! challenge, :id, :description, :created_at
  json.url challenge_url(challenge, format: :json)
  json.photos do
    json.count challenge.photos.count
  end
  json.user do
    json.partial! 'users/user', user: challenge.user
  end
end
