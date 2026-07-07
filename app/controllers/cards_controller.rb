class CardsController < ApplicationController
  STATUSES = { "draft" => "Draft", "active" => "Active", "inactive" => "Inactive", "archived" => "Archived" }.freeze

  before_action :set_deck

  def new
    @card = @deck.cards.new
  end

  def create
    @card = @deck.cards.new(card_params)

    if @card.save
      @card_assemblies = @card.card_assemblies.includes(:gift_assembly).order(:position, :id)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to deck_card_path(@deck, @card), notice: "Card added." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @card = @deck.cards.find(params[:id])
    @card_assemblies = @card.card_assemblies.includes(:gift_assembly).order(:position, :id)
  end

  def available_assemblies
    @card = @deck.cards.find(params[:id])
    used_ids = @deck.card_assemblies.select(:gift_assembly_id)
    @available = GiftAssembly.where.not(id: used_ids).order(:name)
  end

  def destroy
    @card = @deck.cards.find(params[:id])
    @card.destroy
    redirect_to deck_path(@deck), notice: "Card deleted."
  end

  private

  def set_deck
    @deck = Deck.find(params[:deck_id])
  end

  def card_params
    params.require(:card).permit(:name, :status, :image)
  end
end
