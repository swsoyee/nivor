const path = require('path');

module.exports = {
  mode: 'development',
  entry: [
    'regenerator-runtime/runtime.js',
    path.join(__dirname, 'srcjs', 'nivo.tsx'),
  ],
  output: {
    path: path.join(__dirname, 'inst', 'www', '${package}', 'calendar'),
    path: path.join(__dirname, 'inst/htmlwidgets'),
    filename: 'calendar.js',
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        loader: 'babel-loader',
        options: {
          presets: ['@babel/preset-env', '@babel/preset-react'],
        },
      },
    ],
  },
  externals: {
    react: 'window.React',
    'react-dom': 'window.ReactDOM',
    reactR: 'window.reactR',
  },
  stats: {
    colors: true,
  },
  devtool: 'source-map',
};
