class Api::CommentsController < ApiController
  acts_as_token_authentication_handler_for User, only: [:create, :update, :destroy]
  before_action :set_tuit, only: [:index, :show, :create]
    
  def index
    render json: @tuit.comments, status: :ok
  end

  def show
    render json: @tuit.comments.find(params[:id]), status: :ok
  end

  def create
    @comment = current_user.comments.new(body:comment_params[:body],tuit_id:@tuit.id)
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    @comment = current_user.comments.find(params[:id])
    if @comment.update_attributes(comment_params)
      render json: @comment
    else
      render json: @tuit.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    render json: { status: 'Successfully destroyed', data: @comment }, status: :ok
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_tuit
    @tuit = Tuit.find(params[:tuit_id])
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {error: e.message}, status: :unprocessable_entity
  end
  
end