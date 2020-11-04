class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 has_many :posts, dependent: :destroy
 has_many :post_comments, dependent: :destroy
 has_many :favorites, dependent: :destroy
 attachment :profile_image

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
end

