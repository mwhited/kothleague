class Team < ApplicationRecord
    belongs_to :event
    has_and_belongs_to_many :players
    has_one :game
end
