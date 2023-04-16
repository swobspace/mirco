import { StreamActions } from "@hotwired/turbo"
import TomSelect from 'tom-select/dist/js/tom-select.complete.js';

// reinitialize options and items for tomselect

StreamActions.update_select = function() {
  const id = this.getAttribute("id")
  let select = document.getElementById(id);
  let selected = select.value
  let control = select.tomselect

  control.clear()
  control.clearOptions()
  control.sync()
  control.addItem(selected)
}

