class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    if verify_recaptcha(model: resource)
      if resource.save
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        clean_up_passwords resource
        set_minimum_password_length
      end
    else
      clean_up_passwords(resource)
      flash[:alert] = "Failed to pass reCAPTCHA. Please try again."
      redirect_to new_user_registration_path
    end
  end

  private

  def after_sign_up_path_for(resource)
    home_index_path
  end
end
