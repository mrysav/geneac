import '../src/administrate.scss'

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
