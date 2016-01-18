class AddParentToPages < ActiveRecord::Migration
  def change
    # add_column :page, :parent, :integer

    add_reference :pages, :parent, index: true
  end
end
