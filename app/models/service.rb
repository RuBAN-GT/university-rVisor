class Service < ActiveRecord::Base
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"

  validates :owner_id,
            presence: {
                message: "Сервис должен иметь владельца"
            }
  validates :name,
            presence: {
                message: "Имя сервиса обязательно для заполнения"
            }
  validates :slug,
            presence: {
                message: "Код обязателен для заполнения"
            },
            format:   {
                with:    /\A[a-z0-9_-]{3,255}\z/,
                message: "Разрешены только латинские символы от 3 до 255 символов"
            }
end
