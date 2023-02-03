// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "@rails/actiontext"
import "trix"
import "./controllers"
import "./stream_actions"
import LocalTime from "local-time"
LocalTime.start()

import Bridge from "./bridge/bridge"
window.webBridge = new Bridge()
