class Test < ActiveRecord::Base
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  belongs_to :service, class_name: "Service", foreign_key: "service_id"

  has_attached_file :picture, styles: { :medium => "400x300#", :thumb => "100x100#" }

  validates :owner_id,
            presence: {
                message: "Тест должен иметь владельца"
            }
  validates :name,
            presence: {
                message: "Имя сервиса обязательно для заполнения"
            }

  validates_attachment :picture,
    presence:     {
       message: "Скриншот обязателен для загрузки"
    },
    content_type: {
       message:      "Разрешены файлы формата JPG, JPEG, PNG",
       content_type: ["image/jpg", "image/jpeg", "image/png"]
    }

  def heatmap
    passages = Passage.where(test_id: self.id)

    if passages.length > 0
      path = heatmap_path + "-" + passages.length.to_s + ".png"

      unless self.picture.path.nil? || File.exist?(path)
        clicks = []

        passages.each do |passage|
          clicks += passage.clicks
        end

        map = Heatmap::Image.new

        clicks.each do |click|
          map << click.split(',')
        end

        heatmap_clear

        map.generate self.picture.path, path
      end

      path
    end
  end

  def heatmap_clear
    unless self.picture.path.nil?
      Dir[File.dirname(self.picture.path) + "/heatmap-total-*"].each do |file|
        File.delete file
      end
    end
  end

  protected
  def heatmap_path
    unless self.picture.path.nil?
      File.dirname(self.picture.path) + '/' + "heatmap-total"
    end
  end
end
