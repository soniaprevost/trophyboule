class Game < ActiveRecord::Base
  belongs_to :owner, class_name: "User", foreign_key: :user_id

  has_many :teams, dependent: :destroy

  validates :name, presence: :true
  validates :startdate, presence: :true
end
