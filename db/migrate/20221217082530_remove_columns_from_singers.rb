class RemoveColumnsFromSingers < ActiveRecord::Migration[7.0]
  def change
    remove_column :singers, :born, :string
    remove_column :singers, :biography, :text
    remove_column :singers, :genres, :string
    remove_column :singers, :inst, :string
  end
end
