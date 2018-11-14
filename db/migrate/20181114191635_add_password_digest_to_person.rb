class AddPasswordDigestToPerson < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :password_digest, :string
  end
end
