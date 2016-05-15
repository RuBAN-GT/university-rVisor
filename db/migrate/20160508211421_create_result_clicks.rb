class CreateResultClicks < ActiveRecord::Migration
  def change
    create_table :result_clicks do |t|
      t.references :result, index: true, foreign_key: true
      t.integer :x
      t.integer :y

      t.timestamps null: false
    end
  end
end
