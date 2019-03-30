class Book < ApplicationRecord
    belongs_to :user

    validates :year,
        numericality: { only_integer: true },
        inclusion: { in: 1900..Time.current.year },
        format: {
        with: /(19|20)\d{2}/i,
        message: "should be a four-digit year"
        }

    def author_name
        user.full_name
    end
end
