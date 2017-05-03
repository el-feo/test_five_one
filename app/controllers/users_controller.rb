class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    user = User.new(user_params)

    if user.save
      # TODO: Invoke send email method here
      render json: { status: 'User created successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def confirm
    token = params[:token].to_s

    user = User.find_by(confirmation_token: token)

    if user.present? && user.confirmation_token_valid?
      user.mark_as_confirmed!
      render json: { status: 'User confirmed successfully' }, status: :ok
    else
      render json: { status: 'Invalid Token' }, status: :not_found
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
