class AddColumnsToSingers < ActiveRecord::Migration[7.0]
  def change
    add_column :singers, :popularity, :integer
    add_column :singers, :genres, :text
  end
end
