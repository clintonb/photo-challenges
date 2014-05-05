class Challenge < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  has_and_belongs_to_many :photos
  has_one :daily_challenge
  validates :description, :presence => true
  validates :user_id, :presence => true

  def self.hashtags
    Challenge.pluck(:id).map { |id| "pc#{id}" }
  end

  def self.find_by_hashtags(*hashtags)
    ids = hashtags.map { |hashtag| hashtag[2..-1] }
    Challenge.where(id: ids)
  end

  def hashtag
    "pc#{id}"
  end

  def daily_challenge_date
    daily_challenge.nil? ? nil : daily_challenge.created_at
  end
end
