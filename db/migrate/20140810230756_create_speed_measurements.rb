class CreateSpeedMeasurements < ActiveRecord::Migration
  def change
    create_table :speed_measurements do |t|
      t.decimal :upload
      t.decimal :download
      t.integer :latency

      t.timestamps
    end
  end
end
