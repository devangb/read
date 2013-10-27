class BooksController < ApplicationController
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
    @review = Review.new
    @reviews = @book.reviews.paginate(page: params[:page])
  end

  def index
    @books = Book.paginate(page: params[:page])
  end

  def update
    @book = Book.find(params[:id])
    :review = Review.create
    respond_to do |format|
      if @book.update_attributes(book_params)
        format.html { redirect_to @book, :notice => ('Book was successfully updated.') }
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

  private

  def book_params
    params.require(:book).permit(:title, :author, :isbn)
  end
end
