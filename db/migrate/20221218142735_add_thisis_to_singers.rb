class AddThisisToSingers < ActiveRecord::Migration[7.0]
  def change
    add_column :singers, :thisis, :string
  end
end
