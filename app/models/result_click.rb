class ResultClick < ActiveRecord::Base
  belongs_to :result

  validates :result_id, presence: true
  validates :x, presence: true
  validates :y, presence: true
end
