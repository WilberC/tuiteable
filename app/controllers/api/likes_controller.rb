class Api::LikesController < ApiController
  acts_as_token_authentication_handler_for User, only: [:create, :update, :destroy]
  before_action :set_tuit, only: [:index]
  
  def index
    render json: @tuit.likes, status: :ok
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def set_tuit
    @tuit = p Tuit.find(params[:tuit_id])
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {error: e.message}, status: :unprocessable_entity
  end
  
end