import { Controller } from 'stimulus'
import Awesomplete from 'awesomplete'
import ajax from '../lib/ajax'

export default class extends Controller {
  static targets = ['value']

  /**
   * Awesomplete-enabled element for attaching autocomplete.
   * @param {Element} element
   */
  connect() {
    const element = this.valueTarget
    const suggestionsUrlTemplate = element.dataset['suggestions']
    const completer = new Awesomplete(element, {
      list: [],
    })

    let lastValue = ''

    element.addEventListener('keyup', (e) => {
      const text = e.target.value
      if (!text || text === lastValue) return

      lastValue = text
      const url = suggestionsUrlTemplate.replace('%s', encodeURIComponent(text))
      ajax.get({
        endpoint: url,
        callback: (response) => {
          completer.list = response
        },
      })
    })
  }
}
