class UsersController < ApplicationController
  def new
  end

  def create
  end

  def show
  	@user = User.find(params[:id])
    @reviews = @user.reviews.paginate(page: params[:page])
  end

  def index
  	@users = User.paginate(page: params[:page])
  end
end
