import chrono from './custom_chrono'
import * as moment from 'moment'

const DATE_FORMAT = 'LL'

let AdvancedDateField = function(element) {
  let naturalElem = element.querySelector('.date-val')
  let helpElem = element.querySelector('.help-text')

  let parsedStr = helpElem.dataset.parsed
  let unknownStr = helpElem.dataset.unknown

  let updateHelp = function(str) {
    let date = moment(chrono.parseDate(str))
    if (date.isValid()) {
      helpElem.textContent = `${parsedStr}${date.format(DATE_FORMAT)}`
    } else if (str.trim() !== '') {
      helpElem.textContent = `${parsedStr}${unknownStr}`
    } else {
      helpElem.textContent = ''
    }
  }

  updateHelp(naturalElem.value)

  naturalElem.addEventListener('input', function(event) {
    updateHelp(event.target.value)
  })
}

export default {
  ELEMENT_NAME: '.advanced-date-field',
  activate: AdvancedDateField
}
