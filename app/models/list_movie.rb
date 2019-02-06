class ListMovie < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :movielist
  belongs_to :movie
end
