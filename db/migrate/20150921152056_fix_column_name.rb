class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :relationships, :user_id, :followed_id
  end
end
