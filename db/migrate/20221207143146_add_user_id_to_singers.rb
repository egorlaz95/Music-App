class AddUserIdToSingers < ActiveRecord::Migration[7.0]
  def change
    add_column :singers, :user_id, :integer
  end
end
