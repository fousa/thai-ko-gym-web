class ChangeEnumFieldsToIntegerOnUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :sex,      'integer USING CAST(sex AS integer)'
    change_column :users, :type,     'integer USING CAST(type AS integer)'
    change_column :users, :category, 'integer USING CAST(category AS integer)'
    change_column :users, :rankings, 'integer USING CAST(rankings AS integer)'
  end
end
