// bstabs_controller.js
// trigger bootstrap v5 tabs with url anchor

import { Controller } from "@hotwired/stimulus"
import * as bootstrap from 'bootstrap'

export default class extends Controller {

  connect() {
    const anchor = window.location.hash

    if (anchor) {
      let tabTriggerElement = document.querySelector(anchor) 
      let tab = new bootstrap.Tab(tabTriggerElement)
      tab.show()
    }
  }
}
