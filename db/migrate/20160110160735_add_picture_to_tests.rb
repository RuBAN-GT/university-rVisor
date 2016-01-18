class AddPictureToTests < ActiveRecord::Migration
  def up
    add_attachment :tests, :picture
  end

  def down
    remove_attachment :tests, :picture
  end
end
