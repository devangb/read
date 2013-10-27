class UsersController < ApplicationController
  def new
  end

  def create
  end

  def show
  	@user = User.find(params[:id])
  end

  def index
  end
end
