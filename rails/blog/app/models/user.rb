class User < ApplicationRecord
  ROLE_ADMIN = 'admin'
  ROLE_USER = 'user'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :blog_posts, dependent: :destroy

  validates :role, presence: true, inclusion: { in: [ROLE_ADMIN, ROLE_USER]}

  def admin?
    role == ROLE_ADMIN
  end

  def user?
    role == ROLE_USER
  end
end
