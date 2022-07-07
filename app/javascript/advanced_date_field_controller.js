import { Controller } from 'stimulus'
import ajax from './ajax'

const parse_date_url = '/ajax/parse_date'

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

    ajax.get({
      endpoint: `${parse_date_url}?d=${encodeURI(dateText)}`,
      callback: (date, error) => {
        if (date.trim() !== '') {
          help.textContent = `${parsedStr}${date}`
        } else if (dateText.trim() !== '') {
          help.textContent = `${parsedStr}${unknownStr}`
        } else {
          help.textContent = ''
        }
      },
      parse_json: false,
    })
  }
}
