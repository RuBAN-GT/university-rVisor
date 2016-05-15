class Service < ActiveRecord::Base
  require 'securerandom'

  belongs_to :user, :inverse_of => :services

  has_many :tests, :inverse_of => :service, :dependent => :delete_all

  validates :title, presence: true
  validates :user_id, presence: true
  validates :private_key, presence: true

  before_validation :default_values
  def default_values
    self.private_key ||= SecureRandom.hex(16)
  end
end
