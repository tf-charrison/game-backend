class ScoresController < ApplicationController
  before_action :authorize_request, only: [:create] 

  def index
    top_scores = Score.includes(:user).order(score: :desc).limit(10)

    render json: top_scores.as_json(only: [:score, :difficulty], include: { user: { only: [:id, :username] } })
  end

  def create
    # Associate the score with the authenticated user
    score = @current_user.scores.build(score_params)

    if score.save
      render json: { message: 'Score saved successfully' }, status: :created
    else
      render json: { error: 'Failed to save score', details: score.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def score_params
    params.permit(:score, :difficulty)
  end

  # JWT authentication
  def authorize_request
    header = request.headers['Authorization']
    token = header.split.last if header

    begin
      decoded = JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
      @current_user = User.find(decoded['user_id'])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: { errors: 'Unauthorized' }, status: :unauthorized
    end
  end
end
