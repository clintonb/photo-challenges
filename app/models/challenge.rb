class Challenge < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :photos
  validates :description, :presence => true
  validates :user_id, :presence => true

  def self.hashtags
    Challenge.pluck(:id).map { |id| "pc#{id}" }
  end

  def self.find_by_hashtags(*hashtags)
    ids = hashtags.map { |hashtag| hashtag[2..-1] }
    Challenge.where(:id=>ids)
  end

  def hashtag
    "pc#{id}"
  end
end
