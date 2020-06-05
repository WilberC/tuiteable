class Api::CommentsController < ApiController
  acts_as_token_authentication_handler_for User, only: [:create, :update, :destroy]
  before_action :set_tuit, only: [:index, :show]
    
  def index
    render json: @tuit.comments, status: :ok
  end

  def show
    render json: @tuit.comments.find(params[:id]), status: :ok
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def set_tuit
    @tuit = Tuit.find(params[:tuit_id])
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {error: e.message}, status: :unprocessable_entity
  end
  
end