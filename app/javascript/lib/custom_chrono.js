import * as chrono from 'chrono-node'

const custom = chrono.casual.clone()

// Construct a basic parser for 4-digit years
// (when that is the whole string)

const fourDigitYearParser = {
  pattern: () => /^[1-9][0-9]{3}$/,
  extract: (_, match) => {
    return {
      day: 1,
      month: 1,
      year: parseInt(match[0], 10),
    }
  },
}

custom.parsers.push(fourDigitYearParser)

// Remove the "UnlikelyFormatFilter," which filters
// out number-only dates

const unwantedFmtIdx = custom.refiners.findIndex(
  (f) => f.constructor.name === 'UnlikelyFormatFilter'
)
if (unwantedFmtIdx >= 0) {
  custom.refiners.splice(unwantedFmtIdx, 1)
}

export default custom
