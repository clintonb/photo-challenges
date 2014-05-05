json.array!(@daily_challenges) do |daily_challenge|
  json.partial! 'daily_challenges/show', daily_challenge: daily_challenge
end
