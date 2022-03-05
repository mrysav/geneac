import { Controller } from 'stimulus'
import Awesomplete from 'awesomplete'
import ajax from '../lib/ajax'

const people_tags_url = '/ajax/people_tags'
const person_url = '/p/'

export default class extends Controller {
  static targets = ['value']

  /**
   * Awesomplete-enabled element for inputting a single person.
   * @param {Element} element
   */
  connect() {
    const element = this.valueTarget

    ajax.get(people_tags_url, (peopleList) => {
      let personSearchBox = element.querySelector('.person-field-search')
      let personIdInput = element.querySelector('.person-field-id')
      let selectedPersonElement = element.querySelector(
        '.person-field-selected'
      )
      let personNameField = selectedPersonElement.querySelector('.name')
      let closeBtn = selectedPersonElement.querySelector('.close')

      let populatePersonField = function (personId) {
        personIdInput.value = personId
        ajax.get(`${person_url}${personId}`, function (person) {
          personNameField.textContent = person.title
          selectedPersonElement.style.display = 'inline'
          personSearchBox.style.display = 'none'
          closeBtn.style.display = 'inline'
        })
      }

      closeBtn.addEventListener('click', function (event) {
        personIdInput.value = ''
        selectedPersonElement.style.display = 'none'
        personSearchBox.style.display = 'block'
        closeBtn.style.display = 'none'
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
          },
        })
      }

      personSearchBox.addEventListener(
        'awesomplete-selectcomplete',
        function (event) {
          populatePersonField(event.text.value)
        }
      )

      initializeAwesomplete()
    })
  }
}
