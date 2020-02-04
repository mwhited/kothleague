class Game < ApplicationRecord
  belongs_to :team1, :class_name => "Team"
  belongs_to :team2, :class_name => "Team"
  belongs_to :round
  has_many :rank_history

  validate :complete_with_scores

  private
    def complete_with_scores
      if complete && (t1score == t2score)
        errors.add(:t1score, "cannot be equal to T2score")
      end
    end
end
