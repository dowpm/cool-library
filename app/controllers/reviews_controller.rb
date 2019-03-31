class ReviewsController < ApplicationController
    before_action :find_review, only: [:show, :edit, :update]

    def show
        if !@review
            flash[:notice] = "Review does not exist."
            render plain: flash[:notice]
          #   redirect_to books_path
        end
    end

    def create
        if @review = Review.find_by(user_id: @current_user.id, book_id: params[:review][:book_id]) 
            flash[:message] = "You've already reviewed this book."
            redirect_to user_book_path(@review.book.author_name, @review.book)
        else
            @review = Review.new(review_params)
            if @review.save
            redirect_to user_book_path(@review.book.author_name, @review.book)
            else
                flash[:message] = "Something went wrong."
                redirect_to user_book_path(@review.book.author_name, @review.book)
            end
        end
    end

    private

    def review_params
        params.require(:review).permit(:stars, :comments, :book_id, :user_id)
    end

    def find_review
        @review = Review.find_by(id: params[:id])
    end
end
