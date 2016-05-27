class Screen < ActiveRecord::Base
  belongs_to :test, :inverse_of => :screens

  has_many :result_polls, :inverse_of => :screen, :dependent => :delete_all

  mount_uploader :image, TestScreenUploader

  validates :image, presence: true
end
