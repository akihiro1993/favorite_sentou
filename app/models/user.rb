class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 has_many :posts, dependent: :destroy
 has_many :post_comments, dependent: :destroy
 has_many :favorites, dependent: :destroy
 attachment :profile_image
#フォローフォロワー機能
 has_many :follower, class_name:"Relationship", foreign_key:"follower_id", dependent: :destroy
 has_many :followed, class_name:"Relationship", foreign_key:"followed_id", dependent: :destroy
 has_many :following_user,through: :follower, source: :followed #自分がフォローしてる人
 has_many :follower_user, through: :followed, source: :follower #自分がフォローされている人

def self.search(search,word)
    if search == "forward_match"
                             @user = User.where("name LIKE?","#{word}%")
            elsif search == "backward_match"
                             @user = User.where("name LIKE?","%#{word}")
            elsif search == "perfect_match"
                             @user = User.where("#{word}")
            elsif search == "partial_match"
                             @user = User.where("name LIKE?","%#{word}%")
            else
                             @user = User.all
           end
end

#ユーザーをフォローする
 def follow(user_id)
  follower.create(followed_id: user_id)
 end

#フォローを外す
def unfollow(user_id)
  follower.find_by(followed_id: user_id).destroy
end

#フォロー確認を行う
def following?(user)
  following_user.include?(user)
end

end

