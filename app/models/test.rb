class Test < ActiveRecord::Base
  belongs_to :service, :inverse_of => :tests
  belongs_to :user, :inverse_of => :tests

  has_many :screens, :inverse_of => :test, :dependent => :delete_all
  has_many :results, :inverse_of => :test, :dependent =>  :delete_all

  validates :title, presence: true
  validates :description, presence: true
  validates :public_key, presence: true
  validates :user_id, presence: true
  validates :service_id, presence: true

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

  def poll_results
    if @poll_results.nil?
      polls = {}

      self.screens.each do |screen|
        polls[screen.id] = ResultPoll.where(:screen_id => screen.id).count
      end

      total = polls.inject(0){|sum, (k, v)| sum + v }

      result = {}

      polls.each do |key, item|
        result[key] = item.to_f / total.to_f * 100.to_f
      end

      @poll_results = result
    else
      @poll_results
    end
  end

  def poll_result(id)
    all = poll_results

    (all.key? id) ? all[id] : 0
  end

  def heatmap_generate
    if File.exist?(heatmap_path)
      heatmap_path
    else
      map = Heatmap::Image.new

      self.results.each do |result|
        result.result_clicks.each do |click|
          map << [click.x, click.y]
        end
      end

      map.generate self.screens.first.image.path, heatmap_path
    end
  end

  def heatmap_url
    heatmap_generate

    self.screens.first.image.url + "-heatmap-total.png"
  end

  def destroy_heatmap
    File.delete heatmap_path if File.exist?(heatmap_path)
  end

  protected

    def heatmap_path
      self.screens.first.image.path + "-heatmap-total.png" unless self.screens.first.image.path.nil?
    end
end
