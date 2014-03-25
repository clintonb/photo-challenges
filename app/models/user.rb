class User < ActiveRecord::Base
  validates :email, :presence => true
  validates :first_name, :presence => true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  def get_display_name
    display_name || "#{first_name} #{last_name}".strip
  end
end
