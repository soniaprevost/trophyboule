class TeamsController < ApplicationController

  def update_multiples
    @teams = Game.find(params[:game_id]).teams
    raise @teams.inspect
  end
end
