class Test < ActiveRecord::Base
  belongs_to :service, :inverse_of => :tests
  belongs_to :user, :inverse_of => :tests

  has_many :screens, :dependent => :delete_all

  validates :title, presence: true
  validates :description, presence: true
  validates :public_key, presence: true

  validates :status, :inclusion => { :in => %w(poll opinion clicks) }

  validates :time_status, :inclusion => { :in => %w(free limit) }
  validates :time_limit, :numericality => { :greater_than_or_equal_to => 0 }

  before_validation :default_values
  def default_values
    self.public_key ||= SecureRandom.hex(16)
  end

  def limited?
    time_status == "limit"
  end
end
