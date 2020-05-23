class User < ApplicationRecord
  has_secure_password
  validates :name, {presence:true}
  validates :email, {presence:true,uniqueness:true}

  # ユーザーに紐づく投稿情報を返す
  def posts
    return Post.where(user_id: self.id)
  end

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ユーザーに紐づくリツイート情報を返す
  def retweets
    return Retweet.where(user_id: self.id)
  end
end
