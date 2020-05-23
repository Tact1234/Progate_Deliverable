class Post < ApplicationRecord
  # バリデーション
  validates :content,{presence: true, length: {maximum:140}}
  validates :user_id,{presence: true}

  #アソシエーション
  has_many :retweets

  # 投稿に紐づくユーザー情報を返す
  def user
    return User.find_by(id: self.user_id)
  end

  # 投稿に紐づくいいね情報を返す
  def likes
    return Like.where(post_id: self.id)
  end
end
