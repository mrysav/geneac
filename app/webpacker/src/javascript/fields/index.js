import AdvancedDateField from './advanced_date_field'
import PersonField from './person_field'
import TagListField from './tag_list_field'
import PersonTagListField from './person_tag_list_field'

const fields = [AdvancedDateField, PersonField, TagListField, PersonTagListField]

let config = { childList: true, subtree: true }

let attachFields = () => {
  fields.forEach((field) => {
    let fieldElements = document.querySelectorAll(field.ELEMENT_NAME)
    fieldElements.forEach((element) => {
      if (!element.dataset.activated) {
        field.activate(element)
        element.dataset.activated = true
      }
    })
  })
}

var observer = new MutationObserver(attachFields)
observer.observe(document.documentElement || document.body, config)

// This might not be needed...
document.addEventListener('DOMContentLoaded', function () {
  attachFields()
})
