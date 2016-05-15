class CreateResultPolls < ActiveRecord::Migration
  def change
    create_table :result_polls do |t|
      t.references :result, index: true, foreign_key: true
      t.references :screen, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
