import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["parent", "child"]
  static values = { options: Object, childPlaceholder: { type: String, default: "Select an option" } }

  updateChild() {
    const options = this.optionsValue[this.parentTarget.value] || []
    this.childTarget.replaceChildren(this.placeholderOption(), ...options.map((option) => this.buildOption(option)))
  }

  placeholderOption() {
    const option = document.createElement("option")
    option.value = ""
    option.textContent = this.childPlaceholderValue
    return option
  }

  buildOption(option) {
    const element = document.createElement("option")
    element.value = option.value
    element.textContent = option.label
    return element
  }
}
