import { Controller } from 'stimulus'
import Awesomplete from 'awesomplete'
import ajax from '../lib/ajax'

const people_tags_url = '/ajax/people_tags'
const person_tag_url = '/p'

export default class extends Controller {
  static targets = ['value']

  connect() {
    const element = this.valueTarget

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

    let addTag = function (name, value) {
      value = parseInt(value, 10)
      // if value is NaN or less than 0, return
      if (!(value > 0)) {
        return
      }
      // if value already exists in tag list, return
      if (tagListValues.indexOf(value) > -1) {
        return
      }

      let li = document.createElement('li')
      li.innerHTML = name + ' <span class="close">X</a>'
      li.classList.add('tag-' + value)

      li.querySelector('.close').addEventListener('click', function (event) {
        event.preventDefault()
        deleteTag(value)
      })

      taggedList.appendChild(li)

      tagListValues.push(value)
      syncTagValues()
    }

    let initializeAwesomplete = function (list) {
      return new Awesomplete(textField, {
        list: list,
        replace: function () {
          this.input.value = ''
        },
      })
    }

    textField.addEventListener('awesomplete-selectcomplete', function (event) {
      addTag(event.text.label, event.text.value)
    })

    let tags = tagListValueInput.value.split(',')
    for (let t = 0; t < tags.length; t++) {
      let pid = parseInt(tags[t], 10)
      if (pid > 0) {
        ajax.get({
          endpoint: `${person_tag_url}/${pid}`,
          callback: function (person) {
            addTag(person.title, pid)
          },
        })
      }
    }

    ajax.get({ endpoint: people_tags_url, callback: initializeAwesomplete })
  }
}
