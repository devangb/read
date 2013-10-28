class ReviewsController < ApplicationController
  def new
  	@book = Book.find_using_slug(params[:book_id])
  	@review = Review.new
  	@review.book_id = @book.id
  end

  def create
  	@book = Book.find(params[:id])
  	@review = Review.new(review_params)
     @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = "review created!"
      redirect_to root_url
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
end
