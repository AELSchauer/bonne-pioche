import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview"]

  browse(event) {
    if (event.target === this.inputTarget) return
    this.inputTarget.click()
  }

  over(event) {
    event.preventDefault()
    this.element.dataset.over = "true"
  }

  leave() {
    delete this.element.dataset.over
  }

  drop(event) {
    event.preventDefault()
    delete this.element.dataset.over
    const files = event.dataTransfer.files
    if (files.length) {
      this.inputTarget.files = files
      this.change()
    }
  }

  change() {
    const file = this.inputTarget.files[0]
    if (!file) return

    const reader = new FileReader()
    reader.onload = () => {
      this.previewTarget.innerHTML = `
        <img src="${reader.result}" alt="" class="max-h-16 max-w-full rounded-sm object-cover">
        <span class="text-xs text-text-muted">${file.name}</span>
      `
    }
    reader.readAsDataURL(file)
  }
}
