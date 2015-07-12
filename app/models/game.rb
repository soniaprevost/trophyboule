class Game < ActiveRecord::Base
  after_create :create_teams

  belongs_to :owner, class_name: "User", foreign_key: :user_id

  has_many :teams, dependent: :destroy
  has_many :team_members

  validates :name, presence: :true
  validates :startdate, presence: :true

  def create_teams
    c = 0
    # improve the way names are attributed, make them dependent of team_members_max
    names = ["paris", "chateauroux", "roubaix", "avignon", "surry", "marseille", "briançon", "nantes"]
    while c < self.team_number
      team = Team.create(name: names.delete_at(rand(names.length)), game_id: self.id)
      names
      c += 1
    end
    team
  end

  def completed_teams
    true if self.teams.map(&:is_complete).count(true) == self.team_number
  end
end
