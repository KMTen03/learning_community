class Post < ApplicationRecord

  belongs_to :end_user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  
  validates :title, presence: true
  validates :learning_time, presence: true
  validates :learning_content, presence: true

  
  def save_tags(tags)
    tag_list = tag.split(/[[:blank:]]+/)
    current_tags = self.tags.pluck(:tag_name)
    old_tags = current_tags - tag_list
    new_tags = tags_list - current_tags
    p current_tags
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
  end
  
  def self.create_post_with_tags(post_params, user_id, tag_id)
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    if @post.save
      save_tags(post, tag_ids)
    end
  end
  
  def liked?(end_user)
    likes.where(end_user_id: end_user.id).exists?
  end
  
  def self.search(keyword)
    where("title LIKE ? or learning_time LIKE ? or learning_content LIKE ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
  end
  
  def self.get_ranking(post)
    find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id))
  end
  
  def self.save_tags(post, tag_ids)
    tag_ids&.each do |tag_id|
      PostTag.create(post_id: post.id, tag_id: tag_id)
    end
  end
end
