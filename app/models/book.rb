class Book < ApplicationRecord
    belongs_to :user

    def author_name
        user.full_name
    end
end
