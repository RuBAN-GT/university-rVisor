class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.references :service, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.string :title, null: false
      t.string :info
      t.text :description

      t.string :status, null: false, default: "opinion"

      t.string :time_status, null: false, default: "free"
      t.integer :time_limit, null: false, default: 0

      # t.string :screen, null: false

      t.string :public_key, null: false

      t.timestamps null: false
    end

    add_index :tests, :public_key, unique: true
  end
end
