class TuitsController < ApplicationController
  def index
    @tuits = Tuit.where(parent_id: nil).order(created_at: :desc).first(40)
    @user = current_user
  end

  def show
    @tuit = Tuit.find(params[:id])
  end

  def create_tuit
    body = params[:body]
    Tuit.create(body:body,owner:current_user)
    redirect_to root_path
  end

  def delete_tuit
    p '-------------------------------'
    p params
    p '-------------------------------'
    #p id = params[:id]
    @deletedtuit = Tuit.find(params[:id])
    @deletedtuit.destroy
    redirect_to user_path(current_user)

  end

  def create
  end

  def update
  end

  def destroy
  end
end
