class RenameUserImageToImageName < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :user_image, :image_name
  end
end
