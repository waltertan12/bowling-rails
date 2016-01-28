class Api::GamesController < ApplicationController
  def create
    @game = Game.new
    if @game.save
      render :show
    else
      render json: game.errors.full_messages, status: 422
    end
  end

  def bowl
    @game = Game.includes(:frames, {frames: :rolls}, :rolls)
                .find(params[:game][:id])
    @game.bowl(bowling: params[:game][:bowling])
    if @game
      render :show
    else
      render json: ['Could not find a matching game'], status: 422
    end
  end

  def show
    @game = Game.includes(:frames, {frames: :rolls}, :rolls)
                .find(params[:id])
    if @game
      render :show
    else 
      render json: ['Cannot find game with matching id'], status: 422
    end
  end

  def index
    @games = Game.includes(:frames, {frames: :rolls}, :rolls).all
    render :index
  end

  def destroy
    @game = Game.find(params[:id])
    if @game.destroy
      render :game
    else
      render json: ['Could not destroy game'], status: 422
    end
  end
end
