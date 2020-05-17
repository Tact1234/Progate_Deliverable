class Follow < ApplicationRecord
  validates :user_id,{presence:true}
end
