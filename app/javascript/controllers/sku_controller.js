import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["prefix", "number"]
  static values = { nextNumbers: Object }

  updateNumber() {
    this.numberTarget.value = this.nextNumbersValue[this.prefixTarget.value] || ""
  }
}
