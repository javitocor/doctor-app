class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :name
      t.string :surname
      t.text :medical_history
      t.date :DOB
      t.string :city

      t.timestamps
    end
  end
end
