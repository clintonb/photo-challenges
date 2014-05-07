json.extract! challenge, :id, :created_at, :description, :daily_challenge_date
json.user do
  json.partial! 'users/user', user: challenge.user
end
json.photos do
  json.partial! 'photos/photos', photos: challenge.photos
end
