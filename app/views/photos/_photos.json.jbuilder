json.count photos.count
json.links do
  json.array!(photos) do |photo|
    json.extract! photo, :id, :url
  end
end
