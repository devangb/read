class BooksController < ApplicationController

  before_action :signed_in_user

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book
    else
      render 'new'
    end
  end

  def show
    @book = Book.find(params[:id])
    @review_all = @book.reviews
    @reviews = @book.reviews.paginate(page: params[:page])
    #@user = User.find(params)
  end

  def index
    #@books = Book.paginate(page: params[:page])
    @search = Book.search do
      fulltext params[:search]
      paginate(page: params[:page])
    end
    @books = @search.results
    #@books = Book.paginate(page: params[:page])
  end
  

  def update
    @book = Book.find(params[:id])
    @review = Review.new
    
    respond_to do |format|
      if @book.update_attributes(book_params)
        @review.content = @book.content
        @review.book_id = @book.id
        @review.user_id = current_user.id if user_signed_in?
        @review.save
        Book.update(@book.id, :content => '')
        @book.update_attributes(book_params)
        format.html { redirect_to @book }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def readers
    @title = "Readers"
    @book = Book.find(params[:id])
    @books = @book.readers.paginate(page: params[:page])
    @readers = @book.readers.paginate(page: params[:page])
    render 'show_reader'
  end

  def rate
    @book = Book.find(params[:id])
    @book.rate(params[:stars], current_user, params[:dimension])
    current_user.rate!(@book, :stars)
    render :update do |page|
      page.replace_html @book.wrapper_dom_id(params), ratings_for(@book, params.merge(:wrap => false))
      page.visual_effect :highlight, @book.wrapper_dom_id(params)
    end
  end

  private

  def signed_in_user
      redirect_to new_user_session_path , notice: "Please sign in." unless signed_in?
    end

  def book_params
    params.require(:book).permit(:title, :author, :isbn, :content, :amazon_link, :image)
  end

  def review_params
    params.require(:review).permit(:content)
  end
end
