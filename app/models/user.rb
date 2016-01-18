class User < ActiveRecord::Base
  devise :database_authenticatable, :omniauthable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  has_and_belongs_to_many :roles

  validates :email,
            presence: {
                message: "Почта пользователя обязательна для заполнения"
            }

  def role?(role)
    !!self.roles.find_by_name(role.to_s)
  end
end
