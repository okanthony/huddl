class Team < ActiveRecord::Base
  has_many :users
  has_many :games

  validates :name, presence: true
  validates :sport, presence: true

  SPORTS = [
    "Baseball",
    "Basketball",
    "Soccer"
  ].freeze
end
