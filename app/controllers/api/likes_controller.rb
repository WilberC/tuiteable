class Api::LikesController < ApiController
  acts_as_token_authentication_handler_for User, only: [:create, :update, :destroy]
  before_action :set_tuit
  
  def index
    render json: @tuit.likes, status: :ok
  end

  def create
    if @tuit.likers.exists?(current_user.id)
      render json: {error: "You already like this tuit.", data: @tuit}, status: :unprocessable_entity
    else
      @tuit.likers << current_user 
      render json: @tuit
    end
  end

  def destroy
    unless @tuit.likers.exists?(current_user.id)
      render json: {error: "You don't like this tuit yet.", data: @tuit}, status: :unprocessable_entity
    else 
      Like.find_by(user_id:current_user.id, tuit_id:@tuit.id).destroy
      render json: { status: 'Successfully unliked', data: @tuit }, status: :ok
    end
  end

  private

  def set_tuit
    @tuit = Tuit.find(params[:tuit_id])
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {error: e.message}, status: :unprocessable_entity
  end
  
end