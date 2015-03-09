class Language < ActiveRecord::Base
  has_many :phrases
  has_many :users
end
