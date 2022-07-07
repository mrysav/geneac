import { Controller } from 'stimulus'
import Awesomplete from 'awesomplete'
import ajax from './ajax'

const tag_url = '/ajax/tags'

export default class extends Controller {
  static targets = ['value']

  connect() {
    const element = this.valueTarget

    ajax.get({
      endpoint: tag_url,
      callback: function (list) {
        return new Awesomplete(element, {
          list: list,
          filter: function (text, input) {
            return Awesomplete.FILTER_CONTAINS(text, input.match(/[^,]*$/)[0])
          },

          item: function (text, input) {
            return Awesomplete.ITEM(text, input.match(/[^,]*$/)[0])
          },

          replace: function (text) {
            var before = this.input.value.match(/^.+,\s*|/)[0]
            this.input.value = before + text + ', '
          },
        })
      },
    })
  }
}
