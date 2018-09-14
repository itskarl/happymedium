class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :address
      t.string :image_url
      t.time :start_time
      t.time :end_time
      t.references :itinerary, foreign_key: true

      t.timestamps
    end
  end
end
