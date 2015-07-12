class TeamMember < ActiveRecord::Base
  after_create :attribute_team

  belongs_to :team
  belongs_to :game

  validates :name, presence: :true

  def attribute_team
    available_teams = []
    self.game.teams.all.each do |t|
      available_teams << t unless t.is_complete
    end
    if available_teams.any?
      self.team_id = available_teams.sample.id
      self.save
    else
      # IMPROVE: set flash alert
      raise "All the teams are complete"
    end
  end
end
