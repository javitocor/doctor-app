class AddFilenameToAppointments < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :patient_images, :string
  end
end
