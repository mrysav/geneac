window.CustomizedChrono = (function() {
  let yearParser = new chrono.Parser()

  // Provide search pattern
  yearParser.pattern = function() {
    return /^[1-9][0-9]{3}$/
  }

  // This function will be called when matched pattern is found
  yearParser.extract = (text, ref, match, opt) => {
    return new chrono.ParsedResult({
      ref: ref,
      text: match[0],
      index: match.index,
      start: {
        day: 1, // @todo Not great
        month: 1,
        year: parseInt(match[0], 10)
      }
    })
  }

  let chronoOptions = chrono.options.casualOption()
  let unwantedFmtIdx = chronoOptions.refiners.findIndex(
    f => f.constructor.name === 'UnlikelyFormatFilter'
  )
  if (unwantedFmtIdx >= 0) {
    chronoOptions.refiners.splice(unwantedFmtIdx, 1)
  }

  let custom = new chrono.Chrono(chronoOptions)
  custom.parsers = [yearParser, ...custom.parsers]

  return custom
})()
