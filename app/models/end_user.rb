class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy



  validates :introduce, length: { maximum: 200 }



  def self.guest
    find_or_create_by!(email: "guest@example.com") do |guest|
      guest.password = SecureRandom.urlsafe_base64
      guest.name = "ゲスト"
      guest.is_deleted = false
    end
  end

  def guest_user?
    email == "guest@example.com"
  end
    
  def self.ranking
    find(EndUserPost.group(:end_user_id).order('count(post_id) desc').limit(10).pluck(:end_user_id))
  end
    
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/profile.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg',content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end
end
