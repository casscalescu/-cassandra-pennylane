import { Controller } from "@hotwired/stimulus"
import Tagify from '@yaireo/tagify'

export default class extends Controller {
  static targets = ["ingredientInput"]

  connect() {
    if (this.ingredientInputTarget) {
      new Tagify(this.ingredientInputTarget);
    }
  }
}
