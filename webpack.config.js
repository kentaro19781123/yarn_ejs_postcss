const webpack = require('webpack')

module.exports = {
  entry: [
    'babel-polyfill',
    './src/js/main.js',
  ],

  output: {
    path: `${__dirname}/dist/js`,
    filename: 'main.js',
  },

  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: [
          {
            loader: 'babel-loader',
            options: {
              presets: [
                ['env', { modules: false }],
              ],
            },
          },
        ],
      },
      {
        test: /\.js$/,
        exclude: /(node_modules)/,
        loader: 'eslint-loader',
      },
    ],
  },
  plugins: [
    new webpack.optimize.UglifyJsPlugin({
      sourceMap: false,
    }),
    new webpack.ProvidePlugin({
      jQuery: 'jquery',
      $: 'jquery',
    }),
    new webpack.IgnorePlugin(/^\.\/locale$/, /moment$/)
  ]
}
