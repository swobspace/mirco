import { Controller } from "stimulus"
import SlimSelect from "slim-select"

export default class extends Controller {
  static values = { url: String }

  connect() {
    new SlimSelect({
      select: this.element,
      allowDeselect: true
    })
  }
}
