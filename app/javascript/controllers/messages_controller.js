import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="messages"
export default class extends Controller {
  static targets = [ "message" ]
  static values = { recipient: String }
  static classes = [ "sender" ]

  messageTargetConnected(target) {
    this.scrollToBottom()

    if (target.dataset.from == this.recipientValue) {
      target.classList.add(...this.senderClasses)
    }
  }

  scrollToBottom() {
    this.element.scrollTop = this.element.scrollHeight
  }
}
