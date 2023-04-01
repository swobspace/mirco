import { Controller } from "@hotwired/stimulus"
// import TomSelect from "tom-select"
import TomSelect from 'tom-select/dist/js/tom-select.complete.js';


// Connects to data-controller="select"
export default class extends Controller {

  static values = {
    plugins: { type: Array, default: ['clear_button'] }
  }

  connect() {
    // set basic options
    let options = {
      create: false,
      allowEmptyOption: true,
      sortField: {
        field: "text",
        direction: "asc"
      },
      plugins: this.pluginsValue
    }

    new TomSelect(this.element, options)
  }
}
