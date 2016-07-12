class AddFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name,    :string
    add_column :users, :last_name,    :string
    add_column :users, :sex,          :string
    add_column :users, :birth_date,   :date
    add_column :users, :category,     :string
    add_column :users, :type,         :string
    add_column :users, :rankings,     :string
    add_column :users, :phone_number, :string
    add_column :users, :active,       :boolean
    add_column :users, :comments,     :string
  end
end
