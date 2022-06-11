import { Controller } from "@hotwired/stimulus"
import mediumZoom from 'medium-zoom'

// Connects to data-controller="imagezoom"
export default class extends Controller {
  connect() {
    mediumZoom(this.element, {
      container: {
        top: 64,
      },
    })
  }
}
