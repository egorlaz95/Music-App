class AddMostpopToSingers < ActiveRecord::Migration[7.0]
  def change
    add_column :singers, :mostpop, :string
  end
end
