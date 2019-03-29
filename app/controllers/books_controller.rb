class BooksController < ApplicationController
    before_action :set_book, except: [:index, :create, :new]
    
    def index
        # if params[:user_id]
        #   @user = current_user
        #   @books = @user.books
        # else
          @books = Book.all
        # end
    end

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

    def show
        if !@book
          flash[:notice] = "Book does not exist."
          render plain: flash[:notice]
        #   redirect_to books_path
        end
    end

    def edit
        # @user = current_user
        if !@book
          flash[:notice] = "book does not exist for this user."
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
