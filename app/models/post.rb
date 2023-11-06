class Post < ApplicationRecord
  #validates :learning_time, numericality: { only_integer: true }
  
  belongs_to :end_user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  
  def self.search(keyword)
    where("title LIKE ? or learning_content LIKE ? or learning_time LIKE ?", "%#{sanitize_sql_like(keyword)}%", "%#{sanitize_sql_like(keyword)}%", "%#{sanitize_sql_like(keyword)}%")
  end
    
  def liked?(end_user)
    likes.where(end_user_id: end_user_id).exists?
  end
end
