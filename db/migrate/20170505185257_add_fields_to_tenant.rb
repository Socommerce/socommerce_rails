class AddFieldsToTenant < ActiveRecord::Migration
  def change
     add_column :tenants, :password, :string
     add_column :tenants, :confirm_password, :string
  end
end
