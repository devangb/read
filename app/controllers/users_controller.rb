class UsersController < ApplicationController
  def new
  end

  def create
  end

  before_action :signed_in_user, only: [:show, :destroy, :index, :feed, :following, :followers]
  before_action :admin_user,     only: :destroy
  def show
  	@user = User.find(params[:id])
    @reviews = @user.reviews.paginate(page: params[:page])
  end

  def index
  	@users = User.paginate(page: params[:page])
  end

  def destroy
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @reviews.each do |review|
      review.destroy
    end
    @user.destroy
    
    flash[:success] = "User deleted."
    redirect_to users_url

  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def read
    @title = "Read"
    @user = User.find(params[:id])
    @users = @user.read_books.paginate(page: params[:page])
    @books = @user.read_books.paginate(page: params[:page])
    render 'show_read'
  end

  def rate
    @book = Book.find(params[:id])
    @book.rate(params[:stars], current_user, params[:dimension])
    render :update do |page|
      page.replace_html @book.wrapper_dom_id(params), ratings_for(@book, params.merge(:wrap => false))
      page.visual_effect :highlight, @book.wrapper_dom_id(params)
    end
  end

  

  private 
  def signed_in_user
      redirect_to new_user_session_path , notice: "Please sign in." unless signed_in?
  end

  def current_user?(user)
    user == current_user
  end

  def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
