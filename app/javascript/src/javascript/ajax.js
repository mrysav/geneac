module.exports = (endpoint, callback) => {
  let ajax = new XMLHttpRequest()
  ajax.open('GET', endpoint, true)
  ajax.onload = function() {
    callback(ajax.responseText)
  }
  ajax.send()
}
