import Awesomplete from 'awesomplete'
import '../src/tag_list_field.scss'

const ALL_TAGS = '/ajax/tags'
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
 * Awesomplete-enabled element for tagging people.
 * @param {Element} element
 */
let PersonTagInput = function (element) {
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

  let syncTagValues = function () {
    tagListValueInput.value = tagListValues.join(', ')
  }

  let deleteTag = function (value) {
    value = parseInt(value, 10)
    // if value is NaN or less than 0, return
    if (!(value > 0)) { return }

    let index = tagListValues.indexOf(value)
    if (index > -1) {
      tagListValues.splice(index, 1)
      syncTagValues()
      let li = taggedList.querySelector('li.tag-' + value)
      taggedList.removeChild(li)
    }
  }

  let addTag = function (name, value) {
    value = parseInt(value, 10)
    // if value is NaN or less than 0, return
    if (!(value > 0)) { return }
    // if value already exists in tag list, return
    if (tagListValues.indexOf(value) > -1) { return }

    var li = document.createElement('li')
    li.innerHTML = name + ' <a href="#">(x)</a>'
    li.classList.add('tag-' + value)

    li.querySelector('a').addEventListener('click', function (event) {
      event.preventDefault()
      deleteTag(value)
    })

    taggedList.appendChild(li)

    tagListValues.push(value)
    syncTagValues()
  }

  let initializeAwesomplete = function (peopleTags) {
    var list = JSON.parse(peopleTags)
    return new Awesomplete(textField, {
      list: list,
      replace: function () {
        this.input.value = ''
      }
    })
  }

  textField.addEventListener('awesomplete-selectcomplete', function (event) {
    addTag(event.text.label, event.text.value)
  })

  let tags = tagListValueInput.value.split(',')
  for (let t = 0; t < tags.length; t++) {
    let pid = parseInt(tags[t], 10)
    if (pid > 0) {
      ajax(PERSON_TAG + pid, function (person) {
        addTag(person, pid)
      })
    }
  }

  ajax(ALL_PEOPLE_TAGS, initializeAwesomplete)
}

/**
 * Awesomplete-enabled element for comma-separated tag text field.
 * @param {*} element
 */
let TagInput = function (element) {
  ajax(ALL_TAGS, function (response) {
    var list = JSON.parse(response)
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
      }
    })
  })
}

document.addEventListener('DOMContentLoaded', function () {
  let personTagFields = document.querySelectorAll('.person-tag-field')
  for (let t = 0; t < personTagFields.length; t++) {
    PersonTagInput(personTagFields[t])
  }

  var tagFields = document.querySelectorAll('.tag-field')
  for (var x = 0; x < tagFields.length; x++) {
    TagInput(tagFields[x])
  }
})
