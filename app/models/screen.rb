class Screen < ActiveRecord::Base
  belongs_to :test

  has_many :result_polls, :dependent => :delete_all

  mount_uploader :image, TestScreenUploader

  validates :image, presence: true
end
