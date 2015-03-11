class User < ActiveRecord::Base
  enum  role: [:user, :vip, :admin]
# Save these 2 lines for later development
#  enum  mode: [:speak, :paste]
#  enum voice: [:male, :female, :child, :cartoon]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :categories
  # Do I need this? as the user's language
  # is taken care of by the TLD name
  # what does this buy us?
  belongs_to :language

  include ::Ownership

  def is_admin?
    true
  end

end
