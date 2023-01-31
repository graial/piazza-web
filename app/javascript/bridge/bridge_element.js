export default class BridgeElement {
	constructor(element) {
		this.element = element
	}

	get platform() {
		return document
			.querySelector("meta[name='bridge-platform']").content
	}

	get title() {
		return this.element.vaue || this.element.textContent
	}

	get platformData() {
		return this
			.element.getAttribute(`data-bridge-element-${this.platform}`)
	}

	get id() {
		return this.element.dataset.bridgeElementId
	}

	toMessage() {
		return {
			type: "render",
			data: {
				id: this.id,
				title: this.title,
				...JSON.parse(this.platformData)
			}
		}
	}
}