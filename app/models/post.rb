class Post < ApplicationRecord
  #validates :learning_time, numericality: { only_integer: true }

  belongs_to :end_user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  
  validates :title, presence: true
  validates :learning_time, presence: true
  validates :learning_content, presence: true

  def self.search(keyword)
    where("title LIKE ? or learning_time LIKE ? or learning_content LIKE ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
  end
  
  def self.get_ranking()
    find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id))
  end
  
  def self.get_post_list(is_new_post, is_old_post, tag_id, keyword)
    @posts = Post.all
    if is_new_post
      @posts = Post.new_post
    elsif is_old_post
      @posts = Post.old_post
    elsif tag_id.present?

      @posts = Tag.find(params[:tag_id]).posts
    elsif keyword
      @posts = @posts.search(params[:keyword])
    end

    return @posts.page(params[:page]).per(5)
  end
  
  def liked?(end_user)
    likes.where(end_user_id: end_user.id).exists?
  end
end
