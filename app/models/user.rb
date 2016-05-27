class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :services, :inverse_of => :user, :dependent => :delete_all
  has_many :tests, :inverse_of => :user, :dependent => :delete_all
  has_many :results, :inverse_of => :user, :dependent => :delete_all

  has_and_belongs_to_many :roles, :join_table => :users_roles

  def role?(role)
    !roles.find_by_name(role.to_s).nil?
  end
end
