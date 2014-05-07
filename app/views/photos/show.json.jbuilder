json.extract! @photo, :id, :url
json.user do
  json.partial! 'users/user', user: @photo.user
end
json.challenges do
  json.array!(@photo.challenges) do |challenge|
    json.extract! challenge, :id, :description
  end
end
