class User < ActiveRecord::Base
  ROLES = {
    :user => 0,
    :vip => 1,
    :admin => 2
  }

  has_and_belongs_to_many :categories
  belongs_to :language
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
###
#  These *may* not be needed
###

###  include ::Ownership
###
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
