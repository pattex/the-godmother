class AddStateoPersonAndRemoveVerified < ActiveRecord::Migration[5.2]
  def change
    remove_column :people, :verified, :boolean
    add_column :people, :state, :integer, default: 1
  end
end
