class User < ActiveRecord::Base

  ROLES = {
    user: 0,
    vip: 1,
    admin: 2
  }

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
    self.role == ROLES[:admin]
  end

  def is_vip?
    self.role == ROLES[:vip]
  end

  def is_admin!
    self.update_attributes(role: ROLES[:admin])
  end

  def is_vip!
    self.update_attributes(role: ROLES[:vip])
  end

end
