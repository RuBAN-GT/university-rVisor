class Result < ActiveRecord::Base
  belongs_to :test
  belongs_to :user

  has_many :result_clicks, :dependent => :delete_all
  has_many :result_comments, :dependent => :delete_all

  validates :time_cont, presence: true
end
