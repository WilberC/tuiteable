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
    tuit = Tuit.find(params[:id])
    tuit.comments.each(&:destroy)
    tuit.likes.each(&:destroy)
    related_tuits = Tuit.where(parent_id: tuit.id)
    related_tuits.each do |tuit_related|
      tuit_related.parent_id = nil
      tuit_related.save
    end
    tuit.destroy!
    redirect_to user_path(current_user)

    # @deletedtuit = Tuit.find(params[:id])
    # @deletedtuit.destroy
    # redirect_to user_path(current_user)

  end

  def create
  end

  def update
  end

  def destroy
  end
end
