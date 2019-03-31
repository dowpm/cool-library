class BooksController < ApplicationController
    # before_action :require_login, only: [:index, :show]
    skip_before_action :require_login, except: [:index, :show]
    before_action :require_author, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_book, only: [:show]
    before_action :set_author_book, only: [:edit, :update]
    
    def index
        if params[:user_id]
          @books = @current_user.books
        else
          @books = Book.all
        end
    end

    def new
        @book = Book.new
    end

    def create
        @book = @current_user.books.build book_params
        if @book.save
            redirect_to books_path
        else
            render :new
        end
    end

    def show
        if !@book
          flash[:notice] = "Book does not exist."
          render plain: flash[:notice]
        #   redirect_to books_path
        end
        @review = @book.reviews.build(user_id: @current_user.id)
    end

    def edit
        if !@book
          flash[:notice] = "This book doesn't yours."
          render plain: flash[:notice]
        #   redirect_to books_path
        end
    end

    def update
        if @book.update(book_params)
            redirect_to book_path
        else
            render :edit
        end
    end

    def destroy
        @book.delete
        redirect_to books_path
    end

    private

    def set_book
        @book = Book.find_by(id: params[:id])
    end

    def set_author_book
        @book = @current_user.books.find_by(id: params[:id])
    end

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
