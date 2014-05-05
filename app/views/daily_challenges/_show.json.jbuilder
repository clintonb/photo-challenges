json.extract! daily_challenge, :id, :created_at

json.challenge do
  json.partial! 'challenges/show', challenge: daily_challenge.challenge
end
