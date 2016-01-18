class Page < ActiveRecord::Base
  belongs_to :parent, class_name: "Page", foreign_key: "parent_id"

  validates :title,
            presence: {
                message: "Заголовок обязателен для заполнения"
            }
  validates :slug,
            presence: {
                message: "Код обязателен для заполнения"
            },
            format:   {
                with:    /\A[a-z0-9_-]{3,255}\z/,
                message: "Разрешены только латинские символы от 3 до 255 символов"
            }
  validate do |object|
    object.parent_id == nil? if object.parent_id == 'none'

    if object.id.blank? == false && object.id == object.parent_id
      errors.add(:parent_id, "Страница не может указывать сама на себя")
    elsif object.parent_id.is_a? Integer
      page = Page.find_by_id(object.parent_id)
      unless page.blank?
        errors.add(:parent_id, "Невозможно перекрёстное указание родителя") if page.parent_id == object.id
      else
        object.parent_id = nil
      end
    elsif object.parent_id.nil? == false
      errors.add(:parent_id, "Неверный id страницы")
    end
  end
end