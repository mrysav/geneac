const { generateWebpackConfig, merge } = require('shakapacker')
const webpack = require('webpack')
const webpackConfig = generateWebpackConfig()

// See the shakacode/shakapacker README and docs directory for advice on customizing your webpackConfig.

const customConfig = {
  resolve: {
    extensions: ['.css'],
    alias: {
      d3: 'd3/build/d3.js',
    },
  },
  plugins: [
    new webpack.ProvidePlugin({
      d3: 'd3',
    }),
  ],
}

module.exports = merge(webpackConfig, customConfig)
