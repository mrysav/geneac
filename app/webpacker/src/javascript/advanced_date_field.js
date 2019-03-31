import * as chrono from 'chrono-node'
import * as moment from 'moment'

const DATE_FORMAT = 'LL'

let AdvancedDateField = function (element) {
  let naturalElem = element.querySelector('.date-val')
  let helpElem = element.querySelector('.help-text')

  let parsedStr = helpElem.dataset.parsed
  let unknownStr = helpElem.dataset.unknown

  let updateHelp = function (str) {
    let date = moment(chrono.parseDate(str))
    if (date.isValid()) {
      helpElem.textContent = `${parsedStr}${date.format(DATE_FORMAT)}`
    } else {
      helpElem.textContent = `${parsedStr}${unknownStr}`
    }
  }

  updateHelp(naturalElem.value)

  naturalElem.addEventListener('input', function (event) {
    updateHelp(event.target.value)
  })
}

document.addEventListener('DOMContentLoaded', function () {
  let advancedDateFields = document.querySelectorAll('.advanced-date-field')
  for (let t = 0; t < advancedDateFields.length; t++) {
    AdvancedDateField(advancedDateFields[t])
  }
})
