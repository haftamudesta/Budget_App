class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :email, :password, presence: true

  # ROLES = %w[admin manager editer]
  # ROLES.each do |role_name|
  #   define_method "#{role_name}?" do
  #     role == role_name
  #   end
  # end
end
