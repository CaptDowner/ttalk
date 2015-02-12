class User < ActiveRecord::Base
  enum  role: [:user, :vip, :admin]
  enum  mode: [:speak, :paste]
  enum voice: [:male, :female, :child, :cartoon]

  after_initialize :set_default_role, :if => :new_record?
  after_initialize :set_default_mode
  #, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  def set_default_mode
    self.mode = 0
  end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
