class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  helper_method :current_user, :logged_in?
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def logged_in?
    !!current_user
  end
  def require_user
    if !logged_in?
      flash[:alert] = "Devi effettuare il login per poter eseguire questa azione"
      redirect_to login_path
    end
  end
end
