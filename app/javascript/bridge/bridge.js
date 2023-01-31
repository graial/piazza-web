export default class Bridge {
	constructor() {
		this.pendingMessages = new Set()
		this.ready = false
	}

	send(message) {
		if (this.ready) {
			this.adapter.receive(message)
		} else {
			this.pendingMessages.add(message)
		}
	}

	sendPendingMessages() {
		this.pendingMessages.forEach((message) => {
			this.adapter.receive(message)
			this.pendingMessages.delete(message)
		})
	}

	set adapter(adapter) {
		this._adapter = adapter
		this.nativeActions = new NativeActions()
		this.ready = true 
		this.sendPendingMessages()
	}

	get adapter() {
		return this._adapter
	}

}
class NativeActions {
	click(id) {
		let element =
			document.querySelector(`[data-bridge-element-id='${id}']`)
		element.click()
	}
}