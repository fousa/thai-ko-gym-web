class AddAddressFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :address,    :string
    add_column :users, :postalcode, :string
    add_column :users, :city,       :string
    add_column :users, :country,    :string
  end
end
