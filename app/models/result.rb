class Result < ActiveRecord::Base
  belongs_to :test, :inverse_of => :results
  belongs_to :user, :inverse_of => :results

  has_many :result_clicks, :inverse_of => :result, :dependent => :delete_all
  has_many :result_comments, :inverse_of => :result, :dependent => :delete_all
  has_many :result_polls, :inverse_of => :result, :dependent => :delete_all

  validates :time_cont, presence: true
  validates :test_id, presence: true
  validates :user_id, presence: true


  def heatmap_generate
    if File.exist?(heatmap_path)
      heatmap_path
    else
      map = Heatmap::Image.new

      self.result_clicks.each do |click|
        map << [click.x, click.y]
      end

      map.generate self.test.screens.first.image.path, heatmap_path
    end
  end

  def heatmap_url
    heatmap_generate

    self.test.screens.first.image.url + "-heatmap-#{self.id}.png"
  end

  def destroy_heatmap
    File.delete heatmap_path if File.exist?(heatmap_path)
  end

  protected

    def heatmap_path
      self.test.screens.first.image.path + "-heatmap-#{self.id}.png" unless self.test.screens.first.image.path.nil?
    end
end
