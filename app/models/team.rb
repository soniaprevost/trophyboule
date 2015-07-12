class Team < ActiveRecord::Base
  belongs_to :game

  has_many :team_members, dependent: :destroy

  validates :game, presence: :true
  validates :name, presence: :true

  def is_complete
    true if self.team_members.count == self.game.team_members_max
  end
end
