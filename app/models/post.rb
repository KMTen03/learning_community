class Post < ApplicationRecord
  
  belongs_to :end_user
  has_many :comments
  has_many :likes
  has_many :post_tags
end
