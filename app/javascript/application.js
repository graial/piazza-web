// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "@rails/actiontext"
import "trix"
import "./controllers"

import Bridge from "./bridge/bridge"
window.webBridge = new Bridge()
