class ReviewsController < ApplicationController
    before_action :find_review, only: [:show, :edit, :update, :destroy]

    def show
        if !@review
            flash[:notice] = "Review does not exist."
            render plain: flash[:notice]
          #   redirect_to books_path
        end
    end

    def create
        if @review = Review.find_by(user_id: @current_user.id, book_id: params[:review][:book_id]) 
            flash["alert alert-info"] = "You've already reviewed this book."
            redirect_to user_book_path(@review.book.author_name, @review.book)
        else
            @review = Review.new(review_params)
            if @review.save
            redirect_to user_book_path(@review.book.author_name, @review.book)
            else
                flash["alert alert-danger"] = "Comment's can't be blank"
                redirect_to user_book_path(@review.book.author_name, @review.book)
            end
        end
    end

    def edit
        # @book = Book.find_by(id: params[:book_id])
        
        if @review.user_id != @current_user.id
          redirect_to books_path
        end
    end

    def update
        @review.update(review_params)

        redirect_to review_path( @review)
    end

    def destroy
        @review.delete

        redirect_to user_book_path(@review.book.author_name, @review.book)
    end

    private

    def review_params
        params.require(:review).permit(:stars, :comments, :book_id, :user_id)
    end

    def find_review
        @review = Review.find_by(id: params[:id])
    end
end
