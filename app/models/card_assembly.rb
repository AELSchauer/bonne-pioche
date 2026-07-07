class CardAssembly < ApplicationRecord
  belongs_to :deck
  belongs_to :card
  belongs_to :gift_assembly

  before_validation { self.deck_id ||= card&.deck_id }

  validates :gift_assembly_id, uniqueness: { scope: :deck_id, message: "is already on a card in this deck" }
  validate :card_belongs_to_deck

  private

  def card_belongs_to_deck
    errors.add(:card, "must be in this deck") if card && card.deck_id != deck_id
  end
end
