class CreateChangeHistories < ActiveRecord::Migration
  def change
    create_table :change_histories do |t|
      t.string :username
      t.string :email
      t.string :change

      t.timestamps
    end
  end
end
