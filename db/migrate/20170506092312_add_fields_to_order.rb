class AddFieldsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :movie_name, :string
    add_column :orders, :theatre_name, :string
    add_column :orders, :no_of_seats, :string
    add_column :orders, :time, :string
  end
end
