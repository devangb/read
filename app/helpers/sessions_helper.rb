module SessionsHelper
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def store_previous_location
    session[:return_to] = URI(request.referer).path
  end

  def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
  end


  def current_user?(user)
    user == current_user
  end

end