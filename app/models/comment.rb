class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true, length: { maximum: 250 }
end
