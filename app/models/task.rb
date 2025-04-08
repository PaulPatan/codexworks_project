class Task < ApplicationRecord
  belongs_to :todo_list
  has_many :notes, as: :notable, dependent: :destroy

  validates :content, presence: true
end
