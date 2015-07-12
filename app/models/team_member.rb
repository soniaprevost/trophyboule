class TeamMember < ActiveRecord::Base
  belongs_to :team
  belongs_to :game

  validates :name, presence: :true
end
