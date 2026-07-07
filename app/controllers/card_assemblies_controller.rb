class CardAssembliesController < ApplicationController
  before_action :set_deck

  def create
    @card = @deck.cards.find(params[:card_id])
    @gift_assembly = GiftAssembly.find(params[:gift_assembly_id])
    @card_assembly = @deck.card_assemblies.build(card: @card, gift_assembly: @gift_assembly)

    if @card_assembly.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to deck_card_path(@deck, @card), notice: "Added #{@gift_assembly.name}." }
      end
    else
      error = @card_assembly.errors.full_messages.to_sentence
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("available_assembly_#{@gift_assembly.id}",
            partial: "cards/unavailable_assembly_row", locals: { gift_assembly: @gift_assembly, error: error })
        end
        format.html { redirect_to available_assemblies_deck_card_path(@deck, @card), alert: error }
      end
    end
  end

  def destroy
    @card_assembly = @deck.card_assemblies.find(params[:id])
    @card = @card_assembly.card
    @card_assembly.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to deck_card_path(@deck, @card), notice: "Removed." }
    end
  end

  def move
    @card_assembly = @deck.card_assemblies.find(params[:id])
    @source_card = @card_assembly.card
    @target_card = @deck.cards.find(params[:to_card_id])

    if @source_card == @target_card
      head :ok
      return
    end

    @card_assembly.update!(card: @target_card)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to deck_card_path(@deck, @source_card) }
    end
  end

  private

  def set_deck
    @deck = Deck.find(params[:deck_id])
  end
end
