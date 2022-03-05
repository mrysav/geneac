/* eslint no-console:0 */

require('trix')
require('@rails/actiontext')

import { Application } from 'stimulus'
import { definitionsFromContext } from 'stimulus/webpack-helpers'

const application = Application.start()
const context = require.context('../controllers', true, /\.js$/)
application.load(definitionsFromContext(context))

// These two functions are used by some customized Administrate views and
// should probably be removed or moved to a Stimulus component

window.confirmWithMessage = function (message) {
  return function (e) {
    e = e || window.event
    if (!confirm(message)) {
      e.preventDefault()
    }
  }
}

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
