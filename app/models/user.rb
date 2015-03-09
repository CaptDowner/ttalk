class User < ActiveRecord::Base
  enum  role: [:user, :vip, :admin]
  enum  mode: [:speak, :paste]
  enum voice: [:male, :female, :child, :cartoon]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :categories
  belongs_to :language

  include ::Ownership

  def moderator?
    false
  end
end
