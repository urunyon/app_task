class BookComment < ApplicationRecord
  
  belongs_to :user
  belongs_to :book
  
  validates :comment, presence: true#空コメントを防ぐバリデーション
end
