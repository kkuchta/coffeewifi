class CreateSpeedMeasurements < ActiveRecord::Migration
  def change
    create_table :speed_measurements do |t|
      t.decimal :up
      t.decimal :down

      t.timestamps
    end
  end
end
