class ChangeCommentTypeOnUser < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :comments, :text
  end
end
