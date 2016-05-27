class ChangeXYTypes < ActiveRecord::Migration
  def change
    change_table :result_clicks do |t|
      t.change :x, :real
      t.change :y, :real
    end
  end
end
