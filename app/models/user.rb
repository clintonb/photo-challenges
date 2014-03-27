class User < ActiveRecord::Base
  validates :email, :presence => true
  validates :first_name, :presence => true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  def display_name
    self.read_attribute(:display_name) || "#{first_name} #{last_name}".strip
  end

  def self.find_or_create_from_tweet!(tweet)
    tweeter = tweet.user
    password = Faker::Internet.password
    user = User.where(twitter_id: tweeter.id.to_s).first_or_create!(first_name: tweeter.name, email: "#{tweeter.id}@twitter.fake", password: password)
    user
  end
end
