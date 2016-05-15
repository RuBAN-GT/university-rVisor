class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :test, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.integer :time_cont, null: false, default: 0

      t.text :main_comment

      t.timestamps null: false
    end
  end
end
