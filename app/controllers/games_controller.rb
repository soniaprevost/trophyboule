class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]

  before_action :find_game, only: [:show, :edit, :update, :destroy]

  def index
    @games = Game.all
  end

  def show
  end

  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.new(game_params)

    if @game.save
      redirect_to game_team_members_path(@game)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @game.update(game_params)
  end

  def destroy
    @game.destroy
  end

  private

  def game_params
    params.require(:game).permit(:name, :startdate, :team_number, :team_members_max)
  end

  def find_game
    @game = Game.find(params[:id])
  end

end
