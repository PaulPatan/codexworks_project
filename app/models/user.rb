class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  has_many :todo_lists, dependent: :destroy
  has_many :shared_lists, dependent: :destroy
  has_many :shared_todo_lists, through: :shared_lists, source: :todo_list

  validates :email, presence: true, uniqueness: true, length: { minimum: 3 }

  validate :password_complexity

  private
  def password_complexity
    return if password.blank?

    unless password.match?(/\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+\z/)
      errors.add :password, "must include at least one uppercase letter, one lowercase letter, and one digit"
    end
  end
end
