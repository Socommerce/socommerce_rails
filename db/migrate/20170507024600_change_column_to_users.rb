class ChangeColumnToUsers < ActiveRecord::Migration
  def change
  	change_column :users, :twitter_id, :string
  end
end
