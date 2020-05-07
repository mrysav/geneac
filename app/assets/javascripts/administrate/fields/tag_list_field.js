;(function(Awesomplete, ajax, attachField) {
  const ALL_TAGS = '/ajax/tags'

  /**
   * Awesomplete-enabled element for comma-separated tag text field.
   * @param {*} element
   */
  let TagInput = function(element) {
    ajax(ALL_TAGS, function(response) {
      var list = JSON.parse(response)
      return new Awesomplete(element, {
        list: list,
        filter: function(text, input) {
          return Awesomplete.FILTER_CONTAINS(text, input.match(/[^,]*$/)[0])
        },

        item: function(text, input) {
          return Awesomplete.ITEM(text, input.match(/[^,]*$/)[0])
        },

        replace: function(text) {
          var before = this.input.value.match(/^.+,\s*|/)[0]
          this.input.value = before + text + ', '
        }
      })
    })
  }

  attachField({
    ELEMENT_NAME: '.tag-field',
    activate: TagInput
  })
})(Awesomplete, window.ajax, window.attachField)
