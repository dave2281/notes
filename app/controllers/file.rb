class SessionsController < Devise::SessionsController
  def create
    super do |resource|
      if resource.persisted?
        flash[:notice] = "Вход выполнен успешно!"
        redirect_to home_index_path
      end
    end
  end

  private

  def after_sign_in_path_for(resource)
    home_index_path
  end
end
