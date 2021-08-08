class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.string :subject
      t.datetime :starts_at
      t.datetime :ends_at
      t.belongs_to :doctor, null: false, foreign_key: true
      t.belongs_to :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
