class AddRandomIdToPerson < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :random_id, :string
    add_index :people, :random_id, unique: true
  end
end
