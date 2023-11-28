class Like < ApplicationRecord
  
  belongs_to :end_user
  belongs_to :post
  
  validates :post_id, uniqueness: { scope: :end_user_id }
  
  def liked_?(end_user)
    likes.exists?(end_user_id: end_user_id)
  end
  
end
