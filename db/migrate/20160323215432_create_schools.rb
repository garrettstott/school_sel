class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.integer :year_built
      t.string :phone_number
      t.string :address
      t.string :email

      t.timestamps null: false
    end
  end
end
