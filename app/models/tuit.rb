class Tuit < ApplicationRecord
  belongs_to :parent, class_name: 'Tuit', optional: true, counter_cache: true
  has_many :retuits, class_name: 'Tuit', foreign_key: "parent_id"
  belongs_to :owner, class_name: 'User'
  has_many :likes
  has_many :likers, through: :likes, source: :user
  has_many :comments
  has_many :commentators, through: :comments, source: :user
end
