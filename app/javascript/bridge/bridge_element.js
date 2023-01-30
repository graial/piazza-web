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
			.element.getAttributes(`data-bridge-element-${this.platform}`)
	}

	toMessage() {
		return {
			type: "render",
			data: {
				title: this.title,
				...JSON.parse(this.platformData)
			}
		}
	}
}