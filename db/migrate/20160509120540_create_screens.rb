class CreateScreens < ActiveRecord::Migration
  def change
    create_table :screens do |t|
      t.references :test, index: true, foreign_key: true

      t.string :image, null: false

      t.string :comment

      t.integer :order, null: false, default: 0

      t.timestamps null: false
    end
  end
end
