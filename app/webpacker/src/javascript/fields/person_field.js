import Awesomplete from 'awesomplete'
import * as ajax from '../ajax'

const ALL_PEOPLE_TAGS = '/ajax/people_tags'
const PERSON_TAG = '/ajax/people_tag/'

/**
 * Awesomplete-enabled element for inputting a single person.
 * @param {Element} element
 */
let PersonField = function (peopleList, element) {
  let personSearchBox = element.querySelector('.person-field-search')
  let personIdInput = element.querySelector('.person-field-id')
  let selectedPersonElement = element.querySelector('.person-field-selected')
  let personNameField = selectedPersonElement.querySelector('.name')

  let populatePersonField = function (personId) {
    personIdInput.value = personId
    ajax(PERSON_TAG + personId, function (name) {
      personNameField.textContent = name
      selectedPersonElement.style.display = 'inline'
      personSearchBox.style.display = 'none'
    })
  }

  selectedPersonElement.querySelector('i').addEventListener('click', function (event) {
    personIdInput.value = ''
    selectedPersonElement.style.display = 'none'
    personSearchBox.style.display = 'block'
  })

  if (personIdInput.value) {
    populatePersonField(personIdInput.value)
  } else {
    personSearchBox.style.display = 'block'
  }

  let initializeAwesomplete = function () {
    return new Awesomplete(personSearchBox, {
      list: peopleList,
      replace: function () {
        this.input.value = ''
      }
    })
  }

  personSearchBox.addEventListener('awesomplete-selectcomplete', function (event) {
    populatePersonField(event.text.value)
  })

  initializeAwesomplete()
}

export default {
  ELEMENT_NAME: '.person-field',
  activate: (element) => {
    ajax(ALL_PEOPLE_TAGS, (people) => {
      let peopleList = JSON.parse(people)
      PersonField(peopleList, element)
    })
  }
}
