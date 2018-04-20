module.exports = {
  plugins: [
    require('postcss-import')(),
    require('postcss-mixins')(),
    require('postcss-size')(),
    require('postcss-nested')(),
    require('postcss-simple-vars')(),
    require('autoprefixer')({
      "browsers": [
        "ie 11",
        "last 1 Edge versions",
        "last 1 Firefox versions",
        "last 1 Chrome versions",
        "last 1 Safari versions",
        "iOS >= 8",
        "Android >= 4.2",
        "last 1 ChromeAndroid versions"
      ]
    }),
    require('postcss-clearfix')(),
    require('postcss-color-function')(),
    require('postcss-calc')(),
    require('postcss-custom-media')(),
    require('css-mqpacker')(),
    require('csswring')(),
    require('postcss-assets')(),
    require('postcss-conditionals')()
  ]
};
