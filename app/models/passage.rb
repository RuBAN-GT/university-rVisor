class Passage < ActiveRecord::Base
  belongs_to :participant, class_name: "User", foreign_key: "participant_id"
  belongs_to :test, class_name: "Test", foreign_key: "test_id"

  validate do |object|
    clicks_new = []

    unless object.clicks.blank?
      object.clicks.each do |click|
        c = click.split ','

        if c.length >= 2
          c[0] = c[0].to_f
          c[1] = c[1].to_f

          if c[0] > 1
            c[0] = 1
          elsif c[0] < 0
            c[0] = 0
          end
          if c[1] > 1
            c[1] = 1
          elsif c[1] < 0
            c[1] = 0
          end

          clicks_new << "#{c[0]},#{c[1]}"
        end
      end
    end

    object.clicks = clicks_new
  end

  def heatmap
    unless self.test.picture.path.nil? && File.exist?(heatmap_path)
      map = Heatmap::Image.new

      self.clicks.each do |click|
        map << click.split(',')
      end

      map.generate self.test.picture.path, heatmap_path
    end
  end

  after_destroy do |passage|
    unless passage.test.picture.path.nil?
      File.delete File.dirname(passage.test.picture.path) + '/' + "heatmap-#{passage.id}.png"
    end

    passage.test.heatmap_clear
  end

  protected
  def heatmap_path
    unless self.test.picture.path.nil?
      File.dirname(self.test.picture.path) + '/' + "heatmap-#{self.id}.png"
    end
  end
end