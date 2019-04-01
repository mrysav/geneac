import 'bootstrap'

import '../src/javascript/tag_list_field'
import '../src/javascript/advanced_date_field'
import '../src/javascript/person_field'

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
