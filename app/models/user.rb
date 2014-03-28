class User < ActiveRecord::Base
  has_many :authentications
  validates :email, :presence => true
  validates :first_name, :presence => true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  def display_name
    username || "#{first_name} #{last_name}".strip
  end

  def self.find_or_create_from_tweet!(tweet)
    tweeter = tweet.user
    password = Faker::Internet.password
    authentication = Authentication.find_by_provider_and_uid('twitter', tweeter.id)

    if authentication
      user = authentication.user
    else
      user = User.new(first_name: tweeter.name, email: "#{tweeter.id}@twitter.fake", password: password)
      user.authentications.build(provider: 'twitter', uid: tweeter.id)
      user.save
    end

    user
  end

  def apply_omniauth(omni)
    authentications.build(:provider => omni['provider'], :uid => omni['uid'], :token => omni['credentials']['token'], :token_secret => omni['credentials']['secret'])
  end
end
