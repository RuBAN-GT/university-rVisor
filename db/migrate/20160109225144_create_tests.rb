class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :name
      t.string :info

      t.references :service, references: :services

      t.references :owner, references: :users

      t.timestamps null: false
    end
  end
end
