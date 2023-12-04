const path = require('path');

module.exports = {
  mode: 'production',
  entry: './app.js',
  output: {
    path: path.join(__dirname, 'dist'),
    publicPath: '/',
    filename: 'main.js',
  },
  target: 'node',
};