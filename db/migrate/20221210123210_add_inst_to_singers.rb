class AddInstToSingers < ActiveRecord::Migration[7.0]
  def change
    add_column :singers, :inst, :string
  end
end
