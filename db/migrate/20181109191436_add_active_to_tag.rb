class AddActiveToTag < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :active, :boolean, defaul: false
  end
end
