class ApplicationController < ActionController::Base
  before_action :authenticate_user_from_device

  private

  def authenticate_user_from_device
    unless user_signed_in?
      redirect_to new_user_session_path, alert: "Please, log in or sign up to use this app"
    end
  end

end
