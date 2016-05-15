class ResultComment < ActiveRecord::Base
  belongs_to :result

  validates :x, presence: true
  validates :y, presence: true
  validates :comment, presence: true
  validates :color, :inclusion => { :in => %w(poll opinion clicks time) }
end
