class RenameFieldInUser < ActiveRecord::Migration
  def change
    rename_column :users, :tenant_id, :twitter_id
  end
end