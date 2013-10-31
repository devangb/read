class Users::RegistrationsController < Devise::RegistrationsController

 def destroy
    @user = User.find(current_user.id)
    @reviews = @user.reviews
    @reviews.each do |review|
      review.destroy
    end
    @user.destroy
    
    flash[:success] = "User deleted."
    redirect_to new_user_registration_path

  end
end