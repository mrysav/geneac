window.ajax = (endpoint, callback) => {
  let req = new XMLHttpRequest()
  req.open('GET', endpoint, true)
  req.onload = function() {
    callback(req.responseText)
  }
  req.send()
}
