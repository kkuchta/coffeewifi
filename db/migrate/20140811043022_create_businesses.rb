class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.string :yelp_id
      t.string :display_name

      t.timestamps
    end
  end
end
