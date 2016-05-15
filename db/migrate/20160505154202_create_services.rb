class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :title, null: false
      t.string :info

      t.string :private_key, null: false

      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :services, :private_key, unique: true
  end
end
