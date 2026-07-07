class DecksController < ApplicationController
  STATUSES = { "draft" => "Draft", "active" => "Active", "inactive" => "Inactive", "archived" => "Archived" }.freeze
  TIERS = { "common" => "Common", "uncommon" => "Uncommon", "rare" => "Rare", "legendary" => "Legendary" }.freeze

  def index
    @decks = Deck.includes(:cards).order(:name)
  end

  def show
    @deck = Deck.find(params[:id])
    card = @deck.cards.order(:name).first

    if card
      redirect_to deck_card_path(@deck, card)
    else
      redirect_to new_deck_card_path(@deck)
    end
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck = Deck.new(deck_params)

    if @deck.save
      redirect_to new_deck_card_path(@deck), notice: "Deck saved."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @deck = Deck.find(params[:id])
  end

  def update
    @deck = Deck.find(params[:id])

    if @deck.update(deck_params)
      redirect_to deck_path(@deck), notice: "Deck saved."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @deck = Deck.find(params[:id])
    @deck.destroy
    redirect_to decks_path, notice: "Deck deleted."
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :tier, :status)
  end
end
