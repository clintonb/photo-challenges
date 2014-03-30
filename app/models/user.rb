class User < ActiveRecord::Base
  acts_as_voter
  has_many :authentications
  has_many :photos
  has_many :challenges
  has_many :answered_challenges, through: :photos, source: :challenges, uniq: true
  validates :email, :presence => true
  validates :first_name, :presence => true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  def to_param
    username || id
  end

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

  def profile_image_url(size=30)
    hash = Digest::MD5.hexdigest(email.downcase)
    "http://www.gravatar.com/avatar/#{hash}?s=#{size}&d=mm"
  end
end
