class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge
  validates :url, :presence => true
  validates :user_id, :presence => true
  validates :challenge_id, :presence => true
end
