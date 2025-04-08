class TodoList < ApplicationRecord
  belongs_to :user

  has_many :tasks, dependent: :destroy
  has_many :shared_lists, dependent: :destroy
  has_many :shared_users, through: :shared_lists, source: :user
  has_many :notes, as: :notable, dependent: :destroy

  validates :title, presence: true
end
