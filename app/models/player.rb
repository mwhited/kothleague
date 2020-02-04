class Player < ApplicationRecord
  belongs_to :event
  has_and_belongs_to_many :rounds
  has_and_belongs_to_many :teams
  has_many :rank_histories
end
