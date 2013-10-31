class ReviewsController < ApplicationController
  before_action :signed_in_user
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
      @feed_items = []
      render 'static_pages/home'
  	end
  end


  def destroy
    store_previous_location
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to store_previous_location
  end

  private

  def review_params
  	params.require(:review).permit(:content)
  end

  def signed_in_user
      redirect_to new_user_session_path , notice: "Please sign in." unless signed_in?
  end
end
