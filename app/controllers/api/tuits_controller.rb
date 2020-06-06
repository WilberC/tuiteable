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
    @tuit = current_user.tuits.new(tuit_params)
    if @tuit.save
      render json: @tuit
    else
      render json: @tuit.errors, status: :unprocessable_entity
    end
  end

  def update
    @tuit = current_user.tuits.find(params[:id])
    if @tuit.update_attributes(tuit_params)
      render json: @tuit
    else
      render json: @tuit.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @tuit = current_user.tuits.find(params[:id])
    @tuit.destroy
    render json: { status: 'Successfully destroyed', data: @tuit }, status: :ok
  end

  private

  def tuit_params
    params.require(:tuit).permit(:body)
  end
 
  def set_owner
    @user = User.find(params[:user_id])
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {error: e.message}, status: :unprocessable_entity
  end
  
end