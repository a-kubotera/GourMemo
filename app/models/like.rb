class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  validates_uniqueness_of :article_id, scope: :user_id
  
  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end
end
