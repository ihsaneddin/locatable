class Customer < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.references :user, index: true
      t.string :status
      t.timestamps
    end

  end
end
