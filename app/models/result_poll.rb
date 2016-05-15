class ResultPoll < ActiveRecord::Base
  belongs_to :result
  belongs_to :screen
end
