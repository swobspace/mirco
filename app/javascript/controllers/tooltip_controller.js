import { Controller } from "@hotwired/stimulus"
import { Tooltip } from "bootstrap"

// Connects to data-controller="tooltip"
export default class extends Controller {
  connect() {
    console.log("tooltip#connect")
    this.tooltip = new bootstrap.Tooltip(this.element)
    // this.tooltip.show()
  }
}
