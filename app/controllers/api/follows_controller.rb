class Api::FollowsController < ApiController
  acts_as_token_authentication_handler_for User, only: [:create, :update, :destroy]
  before_action :set_user, only: [:index, :show]

  def show
    current_uri = p request.env['PATH_INFO'].match /\A.+\/(?<type>[a-z]+)\z/
    @users = current_uri[:type] == 'followers' ? @user.followers : @user.followees
    render json: @users , status: :ok
  end

  def create
    @user.foll = Pokemon.new(pokemon_params)
    if @pokemon.save
      render json: @pokemon
    else
      render json: @pokemon.errors
    end

  end

  def destroy
  end
  
  private

  def set_user
    @user = User.find(params[:user_id])
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {error: e.message}, status: :unprocessable_entity
  end
    
end