class Review < ApplicationRecord
    belongs_to :user
    belongs_to :book
  
    validates :stars, presence: true
    validates :book_id, presence: true
end
