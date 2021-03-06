class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :username
  validates_uniqueness_of :username

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy
  has_many :posts, dependent: :destroy

  def request_friendship(friend)
    self.friendships.create(friend: friend)
  end

  def active_friends
    self.friendships.where(state: "active").map(&:friend) + self.inverse_friendships.where(state: "active").map(&:user)
  end

  def pending_friend_requests_to
    self.friendships.where(state: "pending").map(&:friend)
  end

  def pending_friend_requests_from
    self.inverse_friendships.where(state: "pending").map(&:user)
  end

  def friendship_status(friend)
    friendship = Friendship.where(user_id: [self.id,friend.id], friend_id: [self.id, friend.id])
    unless friendship.any?
      return "not_friends"
    else
      if friendship.first.state == "active"
        return "friends"
      else
        if friendship.first.user == self
          return "pending"
        else
          return "requested"
        end
      end
    end
  end

  def friendship_relation(friend)
    Friendship.where(user_id: [self.id, friend.id], friend_id: [self.id, friend.id]).first
  end
end
