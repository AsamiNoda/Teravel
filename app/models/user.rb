class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image, destroy: false
  has_many :posts, dependent: :destroy
  has_many :post_comments
  has_many :favorites
  has_many :favorite_posts, through: :favorites, source: :post
  has_many :bookmarks
  has_many :bookmark_posts, through: :bookmarks, source: :post

  validates :introduction, length: {maximum: 100}
  validates :name, presence: true, length: {maximum: 10, minimum: 2}, uniqueness: true

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end
end
