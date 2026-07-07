import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source", "field"]
  static values = { showWhen: String }

  connect() {
    if (this.hasSourceTarget) this.toggle()
  }

  toggle() {
    if (!this.hasSourceTarget) return
    const show = this.sourceTarget.value === this.showWhenValue
    this.fieldTargets.forEach((field) => field.classList.toggle("hidden", !show))
  }
}
