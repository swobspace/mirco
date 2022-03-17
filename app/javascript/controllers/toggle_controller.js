import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets = ["content"]
  static classes = ["toggle"]

  toggle() {
    this.contentTargets.forEach((t) => t.classList.toggle(this.toggleClass))
  }

  toggleAll(event) {
    const tclass = this.toggleClass
    
    this.element.querySelectorAll('[data-toggle-target="content"]').forEach(function(t) {
      if (t.classList.contains(tclass)) {
        t.classList.remove(tclass)
      } else {
        t.classList.add(tclass)
      }
    })
  }
}
