class RemoveNameNumberFromCards < ActiveRecord::Migration[5.2]
  def change
    remove_column :cards, :number, :integer
  end
end
