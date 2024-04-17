class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    if verify_recaptcha(model: self.resource) && resource.save
      sign_up(resource_name, resource)
      redirect_to home_index_path
    else
      clean_up_passwords(resource)
      render :new, alert: "reCAPTCHA verification failed."
    end
  end
end
