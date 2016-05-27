class ResultPoll < ActiveRecord::Base
  belongs_to :result, :inverse_of => :result_polls
  belongs_to :screen, :inverse_of => :result_polls

  validates :result_id, presence: true
  validates :screen_id, presence: true
end
