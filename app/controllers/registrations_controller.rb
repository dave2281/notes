class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    if verify_recaptcha(model: resource)
      if resource.save
        sign_up(resource_name, resource)
        redirect_to home_index_path
      else
        clean_up_passwords(resource)
        redirect_to new_user_registration_path, alert: resource.errors.full_messages.join(", ")
      end
    else
      clean_up_passwords(resource)
      render :new, alert: "reCAPTCHA false"
    end
  end
end
