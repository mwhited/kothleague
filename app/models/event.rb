class Event < ApplicationRecord
    has_many :rounds
    has_many :players
    has_many :teams
    has_many :games, :through => :rounds

    validates :name, presence: true
end
