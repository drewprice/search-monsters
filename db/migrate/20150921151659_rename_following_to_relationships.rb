class RenameFollowingToRelationships < ActiveRecord::Migration
  def change
    rename_table :followings, :relationships
  end
end
