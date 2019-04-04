const path = require('path');
const webpack = require('webpack');

module.exports = {

  entry: {
      'mercury' : './template-src/js/mercury.js',
  },

  output: {
      path: path.resolve(__dirname, 'build/npm/js'),
      filename: '[name].js'
  },

  optimization: {
      splitChunks: {
          chunks: "async",
          minChunks: 2
      }
  },

  devtool: 'source-map',

  mode: 'production',
  // mode: 'development',

  plugins: [
      new webpack.ProgressPlugin(),
      new webpack.ProvidePlugin({
          // inject jQuery module as global var for Bootstrap and other legacy scripts
          // did not work so well for script-loader and revolution slider, hence the expose-loader below
          $: 'jquery',
          jQuery: 'jquery',
          'window.jQuery': 'jquery'
      }),
      new webpack.DefinePlugin({
          WEBPACK_SCRIPT_VERSION: '"'
              + ((new Date()).toLocaleDateString('de-DE', { formatMatcher : 'basic', year: '2-digit', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit' } ))
              + '"'
      })
  ],

  module: {
      // expose jQuery to the global scope, required for script-loader and script-loader and revolution slider
      rules: [{
        test: require.resolve('jquery'),
        use: [{
          loader: 'expose-loader',
          options: 'jQuery'
        },{
          loader: 'expose-loader',
          options: '$'
        }]
      }]
    }
};