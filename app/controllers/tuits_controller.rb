class TuitsController < ApplicationController
  def index
    @tuits = Tuit.where(parent_id: nil).order(created_at: :desc).first(40)
  end

  def show
    @tuit = Tuit.find(params[:id])
  end

  def create
  end

  def update
  end

  def destroy
  end
end
