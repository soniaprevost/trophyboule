class TeamMembersController < ApplicationController
  before_action :find_game, only: [:index, :create, :edit, :update]
  before_action :find_team_member, only: [:edit, :update, :destroy]
  def index
    @team_members = @game.team_members
    @team_member = TeamMember.new
  end

  def create
    @team_member = TeamMember.new(team_member_params)
    @team_member.game_id = @game.id
    if @team_member.save
      redirect_to game_team_members_path(@game)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @team_member.game_id = @game.id
    @team_member.update(team_member_params)

    redirect_to game_team_members_path(@game)
  end

  def destroy
    @team_member.destroy

    redirect_to game_team_members_path(@game)
  end

  private

  def team_member_params
    params.require(:team_member).permit(:name)
  end

  def find_game
    @game = Game.find(params[:game_id])
  end

  def find_team_member
    @team_member = @game.team_members.find(params[:id])
  end

end
