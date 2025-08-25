class CreateLocatableTables < ActiveRecord::Migration[7.0]
  def change

    create_table :locatable_locations, force: :cascade do |t|
      t.references :parent, index: true
      t.references :locatable, polymorphic: true, index: true
      t.string  :name
      t.string  :label
      t.string  :context
      t.string  :slug, index: true

      # Full address fields
      t.string  :unit
      t.string  :building_name
      t.string  :street
      t.string  :city
      t.string  :state
      t.string  :postcode
      t.string  :country
      t.decimal :latitude,  precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.string :full_address

      t.datetime :deleted_at
      t.string :type
      t.timestamps
    end

    create_table :locatable_location_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    create_table :locatable_locators, force: :cascade do |t|
      t.references :location, index: true
      t.references :locatable, polymorphic: true, index: true
      t.string :context
      t.string :type
      t.datetime :deleted_at
      t.timestamps
    end

  end
end