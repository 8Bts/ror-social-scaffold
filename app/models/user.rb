class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships

  has_many :requested_friendships, -> { where status: false }, class_name: 'Friendship'
  has_many :recieved_friendships, -> { where status: false }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :mutual_friendships, -> { where status: true }, class_name: 'Friendship'

  has_many :friends, through: :mutual_friendships, source: :friend
  has_many :pending_friends, through: :requested_friendships, source: :friend
  has_many :friendship_requests, through: :recieved_friendships, source: :user

  def confirm_friendship(user)
    friendship_record = recieved_friendships.find_by(user_id: user.id)
    friendship_record.status = true
    friendship_record.save

    Friendship.create(user_id: id, friend_id: user.id, status: true)
  end

  def friend?(user)
    friends.include?(user)
  end
end
