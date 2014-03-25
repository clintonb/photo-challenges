class Challenge < ActiveRecord::Base
  belongs_to :user
  has_many :photos
  validates :description, :presence => true
  validates :user_id, :presence => true
end
