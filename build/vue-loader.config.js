module.exports = {
  preserveWhitespace: false,
  postcss: [
    require('autoprefixer')({
      browsers: ['last 3 versions']
    }),
    require('postcss-px2rem')({remUnit: 37.5})
  ]
}
