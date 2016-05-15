class ResultClick < ActiveRecord::Base
  belongs_to :result

  validates :x, presence: true
  validates :y, presence: true
end
