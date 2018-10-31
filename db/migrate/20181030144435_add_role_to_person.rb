class AddRoleToPerson < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :role, :integer, default: 1
  end
end
