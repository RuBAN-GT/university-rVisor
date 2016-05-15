class Screen < ActiveRecord::Base
  belongs_to :test

  mount_uploader :image, TestScreenUploader

  validates :image, presence: true
end
