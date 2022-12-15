class AddAvatarToSingers < ActiveRecord::Migration[7.0]
  def change
    add_column :singers, :avatar, :string
  end
end
