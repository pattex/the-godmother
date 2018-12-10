class AddGroupIdToPerson < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :group_id, :integer
  end
end
