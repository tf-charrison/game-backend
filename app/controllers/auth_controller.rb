class AuthController < ApplicationController
  # POST /register
  def register
    user = User.new(user_params)

    if user.save
      render json: { message: 'User created successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /login
  def login
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      token = encode_token(user.id)
      render json: { token: token }
    else
      render json: { message: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private
  def user_params
    # Permit the username field here
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  # Encode JWT token
  def encode_token(user_id)
    JWT.encode({ user_id: user_id }, Rails.application.credentials.secret_key_base, 'HS256')
  end
end
