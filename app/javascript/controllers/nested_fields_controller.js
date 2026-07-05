import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["list", "template", "empty"]

  add(event) {
    event.preventDefault()
    if (this.hasEmptyTarget) this.emptyTarget.remove()
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, Date.now())
    this.listTarget.insertAdjacentHTML("beforeend", content)
  }

  remove(event) {
    event.preventDefault()
    const item = event.target.closest("[data-nested-fields-target='item']")
    const destroyField = item.querySelector("input[name*='_destroy']")
    if (destroyField) {
      destroyField.value = "1"
      item.style.display = "none"
    } else {
      item.remove()
    }
  }
}
