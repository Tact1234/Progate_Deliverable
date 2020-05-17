class RenameFollowColToFollows < ActiveRecord::Migration[6.0]
  def change
    rename_column :follows, :follow_id, :following_user_id
  end
end
