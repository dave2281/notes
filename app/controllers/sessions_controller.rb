class SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    if verify_recaptcha(model: self.resource)
      sign_in(resource_name, resource)
      redirect_to home_index_path
    else
      render :new, alert: "reCAPTCHA verification failed."
    end
  end
end
