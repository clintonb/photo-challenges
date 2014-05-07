json.count photos.count
json.links do
  json.array!(photos) do |photo|
    json.extract! photo, :id, :url
    json.user do
      json.partial! 'users/user', user: photo.user
    end
  end
end
