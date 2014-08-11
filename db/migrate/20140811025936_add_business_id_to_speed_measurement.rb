class AddBusinessIdToSpeedMeasurement < ActiveRecord::Migration
  def change
    add_column :speed_measurements, :business_id, :string
  end
end
