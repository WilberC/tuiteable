class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @join_date = "Joined at #{@user.created_at.strftime('%B %Y')}"
    render :profile
  end

  def show_likes
    @user = User.find(params[:id])
    @join_date = "Joined at #{@user.created_at.strftime('%B %Y')}"
    user_liked = @user.likes.map {|like_obj| like_obj.tuit_id}
    @tuits_liked = Tuit.all.select { |tuit| user_liked.include?(tuit.id) }
    render :profile
  end
end
