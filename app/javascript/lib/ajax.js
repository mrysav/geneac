const ajax = {
  get: ({ endpoint, callback, error = null, parse_json = true }) => {
    let req = new XMLHttpRequest()
    req.open('GET', endpoint, true)
    req.setRequestHeader('Accept', 'application/json')
    req.onload = function () {
      if (req.status == 200) {
        if (parse_json) {
          callback(JSON.parse(req.responseText))
        } else {
          callback(req.responseText)
        }
      } else {
        if (error) {
          error(req.status, req.responseText)
        }
      }
    }
    req.send()
  },
}

export default ajax
