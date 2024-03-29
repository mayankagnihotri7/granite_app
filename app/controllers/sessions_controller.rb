class SessionsController < ApplicationController
  before_action :authenticate_user_using_x_auth_token, only: [:destroy]

  def create
    user = User.find_by(email: login_params[:email].downcase)
    if user.present? && user.authenticate(login_params[:password])
      render status: :ok, json: { notice: "Successfully logged in.", auth_token: user.authentication_token, userId: user.id }
    else
      render status: :unprocessable_entity, json: { errors: user.errors.full_messages }
    end
  end

  def destroy
    @current_user = nil
  end

  private

  def login_params
    params.require(:login).permit(:email, :password)
  end
end
