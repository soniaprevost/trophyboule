class Game < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: :true
  validates :startdate, presence: :true
end
