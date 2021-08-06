let attachedFields = []

window.attachField = function (field) {
  attachedFields.push(field)
}

let attachFields = () => {
  attachedFields.forEach((field) => {
    let fieldElements = document.querySelectorAll(field.ELEMENT_NAME)
    fieldElements.forEach((element) => {
      if (!element.dataset.activated) {
        field.activate(element)
        element.dataset.activated = true
      }
    })
  })
}

let observer = new MutationObserver(attachFields)
observer.observe(document.documentElement || document.body, {
  childList: true,
  subtree: true,
})

document.addEventListener('turbolinks:load', function () {
  attachFields()
})
