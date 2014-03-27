class Photo < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :challenges
  belongs_to :data_source
  validates :url, :presence => true
  validates :user_id, :presence => true
  validates :challenges, :presence => true
end
