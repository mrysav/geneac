import Awesomplete from 'awesomplete'
import * as ajax from '../../ajax'

const ALL_PEOPLE_TAGS = '/ajax/people_tags'
const PERSON_TAG = '/ajax/people_tag/'

/**
 * Awesomplete-enabled element for tagging people.
 * @param {Element} element
 */
let PersonTagInput = function(element) {
  let tagListValueInput = element
  tagListValueInput.type = 'hidden'

  let textField = document.createElement('input')
  textField.type = 'text'
  textField.dataset.multiple = true

  let taggedList = document.createElement('ul')

  let parentDiv = document.createElement('div')
  parentDiv.classList.add('person-tag-input')

  let tagListValues = []

  tagListValueInput.parentElement.insertBefore(parentDiv, tagListValueInput)
  parentDiv.appendChild(taggedList)
  parentDiv.appendChild(textField)
  parentDiv.appendChild(tagListValueInput)

  let syncTagValues = function() {
    tagListValueInput.value = tagListValues.join(', ')
  }

  let deleteTag = function(value) {
    value = parseInt(value, 10)
    // if value is NaN or less than 0, return
    if (!(value > 0)) {
      return
    }

    let index = tagListValues.indexOf(value)
    if (index > -1) {
      tagListValues.splice(index, 1)
      syncTagValues()
      let li = taggedList.querySelector('li.tag-' + value)
      taggedList.removeChild(li)
    }
  }

  let addTag = function(name, value) {
    value = parseInt(value, 10)
    // if value is NaN or less than 0, return
    if (!(value > 0)) {
      return
    }
    // if value already exists in tag list, return
    if (tagListValues.indexOf(value) > -1) {
      return
    }

    var li = document.createElement('li')
    li.innerHTML = name + ' <a href="#">(x)</a>'
    li.classList.add('tag-' + value)

    li.querySelector('a').addEventListener('click', function(event) {
      event.preventDefault()
      deleteTag(value)
    })

    taggedList.appendChild(li)

    tagListValues.push(value)
    syncTagValues()
  }

  let initializeAwesomplete = function(peopleTags) {
    var list = JSON.parse(peopleTags)
    return new Awesomplete(textField, {
      list: list,
      replace: function() {
        this.input.value = ''
      }
    })
  }

  textField.addEventListener('awesomplete-selectcomplete', function(event) {
    addTag(event.text.label, event.text.value)
  })

  let tags = tagListValueInput.value.split(',')
  for (let t = 0; t < tags.length; t++) {
    let pid = parseInt(tags[t], 10)
    if (pid > 0) {
      ajax(PERSON_TAG + pid, function(person) {
        addTag(person, pid)
      })
    }
  }

  ajax(ALL_PEOPLE_TAGS, initializeAwesomplete)
}

export default {
  ELEMENT_NAME: '.person-tag-field',
  activate: PersonTagInput
}
