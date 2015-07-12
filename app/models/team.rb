class Team < ActiveRecord::Base
  belongs_to :game

  has_many :team_members, dependent: :destroy

  validates :game, presence: :true
end
