class CreatePassages < ActiveRecord::Migration
  def change
    create_table :passages do |t|
      t.string :comment

      t.string :clicks, array: true

      t.references :test, references: :tests

      t.references :participant, references: :users

      t.timestamps null: false
    end
  end
end
