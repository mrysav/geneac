import Awesomplete from 'awesomplete'

const ALL_PEOPLE_TAGS = '/ajax/people_tags'
const PERSON_TAG = '/ajax/people_tag/'

function ajax (endpoint, callback) {
  var ajax = new XMLHttpRequest()
  ajax.open('GET', endpoint, true)
  ajax.onload = function () {
    callback(ajax.responseText)
  }
  ajax.send()
}

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

document.addEventListener('DOMContentLoaded', function () {
  ajax(ALL_PEOPLE_TAGS, function (peopleList) {
    let personFields = document.querySelectorAll('.person-field')
    for (let t = 0; t < personFields.length; t++) {
      PersonField(JSON.parse(peopleList), personFields[t])
    }
  })
})
