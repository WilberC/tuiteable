class Api::FollowsController < ApiController
  acts_as_token_authentication_handler_for User, only: [:create, :update, :destroy]
  before_action :set_user

  def show
    current_uri = request.env['PATH_INFO'].match /\A.+\/(?<type>[a-z]+)\z/
    @users = current_uri[:type] == 'followers' ? @user.followers : @user.followees
    render json: @users , status: :ok
  end

  def create
    if current_user.eql? @user
      render json: {error: "You can't follow yourself."}, status: :unprocessable_entity
    elsif current_user.followees.exists?(@user.id)
      render json: {error: "You are already following #{@user.username}."}, status: :unprocessable_entity
    else 
      current_user.followees << @user 
      render json: @user      
    end
  end

  def destroy
    unless current_user.followees.exists?(@user.id)
      render json: {error: "You are not following #{@user.username}."}, status: :unprocessable_entity
    else 
      Follow.find_by(follower_id:current_user.id, followee_id:@user.id).destroy
      render json: { status: 'Successfully unfollowed', data: @user }, status: :ok
    end
  end
  
  private

  def set_user
    @user = User.find(params[:user_id])
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {error: e.message}, status: :unprocessable_entity
  end
    
end