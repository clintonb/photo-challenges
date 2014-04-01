class DailyChallenge < ActiveRecord::Base
  belongs_to :challenge
  has_one :user, :through => :challenge
  has_many :photos, :through => :challenge
  validates :challenge_id, :presence => true
end
