class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  has_one_attached :profile_image

  validates :introduce, length: { maximum: 200 } # 自己紹介は200文字まで

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/profile.jpeg') #app/assets/images/profile.jpeg このファイルから画像を参照
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg',content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end


  def self.guest
    find_or_create_by!(email: "guest@example.com") do |guest|
      guest.password = SecureRandom.urlsafe_base64 #パスワードをランダム生成
      guest.name = "ゲスト"
      guest.is_deleted = false #ゲストの退会フラグはfalse
    end
  end

  def guest_user?
    email == "guest@example.com" #メアドが完全一致するとき
  end
    
  def self.ranking
    find(EndUserPost.group(:end_user_id).order('count(post_id) desc').limit(10).pluck(:end_user_id))
    # UserPost.group(:user_id)#記事の番号が同じ物にグループを分ける
    # order('count(post_id) desc')#多い順に並び変える
    # limit(10)#最大10個
    # pluck(:user_id)#そして最後に:user_idカラムのみを数字で取り出すように指定。
    # user_idとpost_idがバラバラ、統一するならpost_idでは？
  end

  def active_for_authentication? #ユーザーが退会していないか判別
    super && (is_deleted == false) #ユーザーのis_deletedがfalseならtrueを返す
  end
end
