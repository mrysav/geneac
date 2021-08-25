const ajax = {
  get: (endpoint, callback, error = null) => {
    let req = new XMLHttpRequest()
    req.open('GET', endpoint, true)
    req.onload = function () {
      if (req.status == 200) {
        callback(req.responseText)
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
