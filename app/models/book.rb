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

    def author_name
        user.full_name
    end
end
# ti = Book.find 2
# ti.reviewers
# mc = User.find 2
# yo = User.find 1
# bad_malis = Review.new(stars:1, comments: 'bad book ever')
# good_malis = Review.new(stars:5, comments: 'good book ever')