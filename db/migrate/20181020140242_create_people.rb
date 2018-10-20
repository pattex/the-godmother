class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :link, limit: 32
      t.string :name
      t.string :pronoun
      t.string :email
      t.text :about
      t.text :special_needs

      t.timestamps
    end
    add_index :people, :link, unique: true
    add_index :people, :email, unique: true
  end
end
