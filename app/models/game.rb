class Game < ActiveRecord::Base
  belongs_to :owner, class_name: "User", foreign_key: :user_id

  has_many :teams, dependent: :destroy
  has_many :team_members


  validates :name, presence: :true
  validates :startdate, presence: :true
end
