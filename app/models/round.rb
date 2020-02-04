class Round < ApplicationRecord
  belongs_to :event
  has_and_belongs_to_many :players
  has_many :games

  validate :started_with_games

  private
    def started_with_games
      if started && numgames < 1
        errors.add(:numgames, "cannot be less than 1 if the round is started")
      end
      if started && players.length < (event.teamsize.present? ? (event.teamsize * numgames): (7*numgames))
        errors.add(:players, "Not enough players (" + players.length.to_s + ") attending to make " + (2*numgames).to_s + " teams of " + event.teamsize.to_s)
      end
    end
end
