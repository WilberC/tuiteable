class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tuits, foreign_key: :owner_id
  has_many :likes
  has_many :liked_tuits, through: :likes, source: :tuit
  has_many :comments
  has_many :commented_tuits, through: :comments, source: :tuit
  # follower_follows "names" the Follow join table for accessing through the follower association
  has_many :follower_follows, foreign_key: :followee_id, class_name: "Follow"
  # source: :follower matches with the belong_to :follower identification in the Follow model 
  has_many :followers, through: :follower_follows, source: :follower

  # followee_follows "names" the Follow join table for accessing through the followee association
  has_many :followee_follows, foreign_key: :follower_id, class_name: "Follow"
  # source: :followee matches with the belong_to :followee identification in the Follow model   
  has_many :followees, through: :followee_follows, source: :followee
  validates :bio, length: {maximum: 160}
  has_one_attached :avatar
  # validates :avatar, file_size: { less_than_or_equal_to: 2.megabytes }
end
