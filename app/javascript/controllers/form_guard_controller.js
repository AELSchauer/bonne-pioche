import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.dirty = false
  }

  markDirty() {
    this.dirty = true
  }

  confirmCancel(event) {
    if (this.dirty && !window.confirm("Discard unsaved changes?")) {
      event.preventDefault()
    }
  }
}
