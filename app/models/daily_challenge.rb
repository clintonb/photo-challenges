class DailyChallenge < ActiveRecord::Base
  belongs_to :challenge
  validates :challenge_id, :presence => true
end
