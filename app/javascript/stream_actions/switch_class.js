import { StreamActions } from "@hotwired/turbo"

StreamActions.switch_class = function() {
	let className = this.getAttribute("class")

	document.querySelectorAll(`.${className}`).forEach(e => {
		e.classList.remove(className)
	})

	this.targetElements.forEach(e => {
		e.classList.add(className)
	})
}