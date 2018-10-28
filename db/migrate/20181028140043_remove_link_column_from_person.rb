class RemoveLinkColumnFromPerson < ActiveRecord::Migration[5.2]
  def change
    remove_column :people, :link, :string
  end
end
