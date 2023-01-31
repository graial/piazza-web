import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="remove-element"
export default class extends Controller {
  remove() {
    this.element.remove()
  }
}
