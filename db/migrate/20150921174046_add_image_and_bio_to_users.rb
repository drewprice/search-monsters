class AddImageAndBioToUsers < ActiveRecord::Migration
  def change
    add_column :users, :image_src, :string
    add_column :users, :bio, :string
  end
end
