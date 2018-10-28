class RemoveSpecialNeedsFromPerson < ActiveRecord::Migration[5.2]
  def change
    change_table :people do |t|
      t.remove :special_needs
    end
  end
end
