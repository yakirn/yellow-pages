var path = require('path');
var webpack = require('webpack');

module.exports = {
    entry: [
        'whatwg-fetch',
        path.join(__dirname, "client/main.js")
    ],
    output: {
        path: path.join(__dirname, 'public/js'),
        filename: "bundle.js"
    },
    module: {
        loaders: [{
            test: /\.jsx?$/,
            exclude: /node_modules/,
            loader: 'babel',
            query: {
                "presets": ["react", "es2015", "stage-0"]
            }
        }]
    }
};
