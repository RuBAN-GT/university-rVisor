class CreateResultComments < ActiveRecord::Migration
  def change
    create_table :result_comments do |t|
      t.references :result, index: true, foreign_key: true
      t.integer :x, null: false
      t.integer :y, null: false
      t.string :color, null: false, default: "yellow"
      t.string :comment, null: false

      t.timestamps null: false
    end
  end
end
