class Book < ApplicationRecord
    belongs_to :author, foreign_key: "user_id", class_name: "User"
    has_many :reviews
    has_many :reviewers, through: :reviews, source: :user

    validates :publication_year,
        numericality: { only_integer: true },
        inclusion: { in: 1900..Time.current.year, message: 'should be between 1900 and this year' },
        format: {
        with: /(19|20)\d{2}/i,
        message: "should be a four-digit year"
        }
        validates :title, presence: true
        validates :isbn, presence: true, uniqueness: true


    def average_rating
        Review.where(book_id: id).average(:stars).to_i
    end

    def author_name
        author.full_name
    end

    def popularity_rating
        self.average_rating + self.ratings.count
    end

    def popular?
      if self.average_rating >= 3
        "#{self.full_name}" + " " + "#{self.popularity_rating}"
      end
    end

    def self.popularity

      Book.all.sort_by do |book|
        book.average_rating
      end.reverse
    end
end