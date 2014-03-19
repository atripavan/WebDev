class CreateWdiRefinedProspects < ActiveRecord::Migration
  def change
    create_table :wdi_refined_prospects do |t|
      t.integer :e_i_n
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.float :income_amount
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :title
      t.boolean :has_donation_button
      t.string :website

      t.timestamps
    end
  end
end
