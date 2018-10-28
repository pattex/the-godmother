class AddVerificationTokenAndVerifiedToPerson < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :verification_token, :string
    add_index :people, :verification_token, unique: true
    add_column :people, :verified, :boolean, default: false
  end
end
