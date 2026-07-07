import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["row", "dropzone"]
  static values = { deckId: Number }

  dragStart(event) {
    event.dataTransfer.effectAllowed = "move"
    event.dataTransfer.setData("text/plain", event.currentTarget.dataset.cardAssemblyId)
  }

  over(event) {
    event.preventDefault()
    event.currentTarget.classList.add("ring-2", "ring-accent")
  }

  leave(event) {
    event.currentTarget.classList.remove("ring-2", "ring-accent")
  }

  drop(event) {
    event.preventDefault()
    event.currentTarget.classList.remove("ring-2", "ring-accent")

    const cardAssemblyId = event.dataTransfer.getData("text/plain")
    const toCardId = event.currentTarget.dataset.cardId
    if (!cardAssemblyId || !toCardId) return

    const token = document.querySelector('meta[name="csrf-token"]')?.content

    fetch(`/decks/${this.deckIdValue}/card_assemblies/${cardAssemblyId}/move`, {
      method: "PATCH",
      headers: {
        Accept: "text/vnd.turbo-stream.html",
        "X-CSRF-Token": token,
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: `to_card_id=${encodeURIComponent(toCardId)}`
    })
      .then((response) => response.text())
      .then((html) => Turbo.renderStreamMessage(html))
  }
}
