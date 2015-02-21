class CategoryPhrase < ActiveRecord::Base
  belongs_to :category
  belongs_to :phrase
end
