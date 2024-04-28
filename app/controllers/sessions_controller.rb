class SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)

    # Перенаправляем только если пользователь успешно аутентифицирован
    if user_signed_in?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      respond_with resource
    end
  end

  private

  def after_sign_in_path_for(resource)
    home_index_path
  end
end