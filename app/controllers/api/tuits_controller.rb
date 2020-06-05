#app/controllers/api/games_controller.rb
class Api::TuitsController < ApiController
  acts_as_token_authentication_handler_for User, only: [:create, :update, :destroy], fallback_to_devise: false
  before_action :set_owner, only: [:index, :show]

  def index
    render json: @user.tuits, status: :ok
  end

  def show
    render json: @user.tuits.find(params[:id]), status: :ok
  end

  def create
  end

  def update
  end

  def destroy
  end

  private
  def set_owner
    @user = User.find(params[:user_id])
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {error: e.message}, status: :unprocessable_entity
  end
  
end