class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :name
      t.string :subdomain
      t.string :company_email
      t.string :company_phone

      t.timestamps null: false
    end
  end
end
