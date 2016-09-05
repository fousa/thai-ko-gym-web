class CreatePresences < ActiveRecord::Migration[5.0]
  def change
    create_table :presences do |t|
      t.integer :user_id
      t.date :present_at
      t.integer :registered_by_id

      t.timestamps
    end
  end
end
