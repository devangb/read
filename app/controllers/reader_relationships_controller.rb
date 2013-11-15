class ReaderRelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @book = Book.find(params[:reader_relationship][:read_id])
    current_user.read!(@book)
    respond_to do |format|
      format.html { redirect_to @book }
      format.js
    end
  end

  def destroy
    @book = ReaderRelationship.find(params[:id]).read
    current_user.unread!(@book)
    respond_to do |format|
      format.html { redirect_to @book }
      format.js
    end
  end
end
