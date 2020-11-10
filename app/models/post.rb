class Post < ApplicationRecord

 belongs_to :user
 attachment :image
 has_many :post_comments, dependent: :destroy
 has_many :favorites,dependent: :destroy

 geocoded_by :address
 after_validation :geocode, if: :address_changed?

 def favorited_by?(user)
 	favorites.where(user_id: user.id).exists?
 end

 def self.search(search, word)
        if search == "forward_match"
                        @post = Post.where("title LIKE?","#{word}%")
        elsif search == "backward_match"
                        @post = Post.where("title LIKE?","%#{word}")
        elsif search == "perfect_match"
                        @post = Post.where("#{word}")
        elsif search == "partial_match"
                        @post = Post.where("title LIKE?","%#{word}%")
        else
                        @post = Post.all
        end
  end
end
