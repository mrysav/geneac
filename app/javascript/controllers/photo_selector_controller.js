import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['photoSelector']

  connect() {
    console.log("I'm here!")
  }
}
