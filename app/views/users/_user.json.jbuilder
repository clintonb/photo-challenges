json.extract! user, :id, :display_name, :profile_image_url
json.photos do
  json.partial! 'photos/photos', photos: user.photos
end

json.counts do
  json.photos user.photos.count
  json.challenges user.challenges.count
  json.answered_challenges user.answered_challenges.count
end
