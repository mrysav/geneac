import 'bootstrap'

import '../src/javascript/fields/index'

window.readImagePreview = function (input) {
  var preview = document.querySelector('#' + input.dataset.preview)
  if (input.files && input.files[0]) {
    var reader = new FileReader()
    reader.onload = function (e) {
      preview.src = e.target.result
    }
    reader.readAsDataURL(input.files[0])
  }
}

window.confirmWithMessage = function (message) {
  return function (e) {
    e = e || window.event
    if (!confirm(message)) {
      e.preventDefault()
    }
  }
}
