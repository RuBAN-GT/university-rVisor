class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string  :slug
      t.string  :name
      t.string  :info
      t.string  :secret_key
      t.string  :public_key

      t.references :owner, references: :users

      t.timestamps null: false
    end
  end
end
