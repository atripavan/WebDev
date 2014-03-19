class CreateWdiProspects < ActiveRecord::Migration
  def change
    create_table :wdi_prospects do |t|
      t.string :e_i_n
      t.string :name
      t.string :in_care_of_name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.float :asset_amount
      t.float :income_amount
      t.float :form_990_revenue_amount

      t.timestamps
    end
  end
end
