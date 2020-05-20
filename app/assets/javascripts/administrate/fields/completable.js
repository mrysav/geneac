;(function(Awesomplete, ajax, attachField) {
  /**
   * Awesomplete-enabled element for autocompletion.
   * @param {*} element
   */
  let CompletableField = function(element) {
    element.classList.remove('completable')
    const completer = new Awesomplete(element, {
      list: []
    })
    const suggestionsUrlTemplate = element.dataset['suggestions']

    let requestVal = ''

    element.addEventListener('keyup', e => {
      const text = e.target.value
      if (!text || text === requestVal) {
        return
      }
      requestVal = text
      const url = suggestionsUrlTemplate.replace('%s', encodeURIComponent(text))
      ajax(url, response => {
        completer.list = JSON.parse(response)
      })
    })
  }

  attachField({
    ELEMENT_NAME: '.completable',
    activate: CompletableField
  })
})(Awesomplete, window.ajax, window.attachField)
