class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.decimal :lat
      t.decimal :lon
      t.string :yelp_id

      t.timestamps
    end
  end
end
