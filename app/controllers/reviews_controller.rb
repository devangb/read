class ReviewsController < ApplicationController
  def create
  	@review = Review.new(review_params)
    @book = Book.find(params[:book_id])
     @review = @book.reviews.build(review_params)
     @review.user_id = current_user.id if user_signed_in?
    if @review.save
      flash[:success] = "review created!"
      redirect_to @book
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

  def review_params
  	params.require(:review).permit(:content)
end
