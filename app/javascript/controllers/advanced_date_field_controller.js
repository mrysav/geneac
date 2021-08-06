import { Controller } from 'stimulus'
import chrono from '../lib/custom_chrono'
import moment from 'moment'

export default class extends Controller {
  static targets = ['help', 'value']

  connect() {
    this.parseDate()
  }

  parseDate() {
    const dateText = this.valueTarget.value
    const help = this.helpTarget

    const parsedStr = help.dataset.parsed
    const unknownStr = help.dataset.unknown

    const date = moment(chrono.parseDate(dateText))
    if (date.isValid()) {
      help.textContent = `${parsedStr}${date.format('LL')}`
    } else if (dateText.trim() !== '') {
      help.textContent = `${parsedStr}${unknownStr}`
    } else {
      help.textContent = ''
    }
  }
}
