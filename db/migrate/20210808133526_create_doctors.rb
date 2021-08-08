class CreateDoctors < ActiveRecord::Migration[6.1]
  def change
    create_table :doctors do |t|
      t.string :name
      t.date :DOB
      t.string :city
      t.text :resume
      t.integer :graduated

      t.timestamps
    end
  end
end
