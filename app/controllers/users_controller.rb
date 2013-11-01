class UsersController < ApplicationController
  def new
  end

  def create
  end

  before_action :signed_in_user, only: [:show, :destroy, :index, :feed]
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
