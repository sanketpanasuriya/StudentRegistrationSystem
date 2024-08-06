# frozen_string_literal: true

class Students::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    student = Student.find_by(email: params[:student][:email])
    if student && student.verified && student.valid_password?(params[:student][:password])
      super
    else
      flash[:alert] = student&.verified ? 'Invalid email or password.' : 'Admin will verify your details soon'
      redirect_to new_student_session_path
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
