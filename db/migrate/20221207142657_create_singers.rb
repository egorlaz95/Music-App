class CreateSingers < ActiveRecord::Migration[7.0]
  def change
    create_table :singers do |t|
      t.string :name
      t.string :born
      t.text :biography
      t.string :genres

      t.timestamps
    end
  end
end
