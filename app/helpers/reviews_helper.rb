module ReviewsHelper
    def show_stars(rating)
        case rating
        when 5
            "⭐️""⭐️""⭐️""⭐️""⭐️"
        when 4
            "⭐️""⭐️""⭐️""⭐️"
        when 3
            "⭐️""⭐️""⭐️"
        when 2
            "⭐️""⭐️"
        when 1
            "⭐️"
        else
        "No ratings yet. Be the first?"
        end
    end

    # def book_id_field(review)
    #     if review.book.nil?
    #         select_tag "review[book_id]", options_from_collection_for_select(Book.all, :id, :name), :prompt => "Select a book"
    #     else
    #         hidden_field_tag "review[book_id]", review.book.id
    #     end
    # end

    # def list_with_names(review)
    # "Book: #{review.book.title} "
    # end
end
