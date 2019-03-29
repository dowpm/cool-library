class BooksController < ApplicationController
    def new
        @book = Book.new
    end

    def create
        @book = Book.new book_params
        if @book.save
            redirect_to books_path
        else
            render :new
        end
    end

    private

    def book_params
        params.require(:book).permit( 
            :title, 
            :isbn, 
            :summary, 
            :publication_year,
            :nbr_page
        )
    end
end
