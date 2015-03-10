class Category < ActiveRecord::Base
  has_many :category_phrases
  # http://www.ruby-journal.com/rails-4-changes-join-table-naming-convention/
  has_and_belongs_to_many :phrases, join_table: :category_phrases
#  has_many :phrases, through: :category_phrases
  has_and_belongs_to_many :users
end
