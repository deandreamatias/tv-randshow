const minify = require('@node-minify/core');
const babelMinify = require('@node-minify/babel-minify');
const cleanCSS = require('@node-minify/clean-css');
const htmlMinifier = require('@node-minify/html-minifier');
const jsonminify = require('@node-minify/jsonminify');

minify({
    compressor: babelMinify,
    input: 'build/web/flutter_service_worker.js',
    output: 'build/web/flutter_service_worker.js',
    callback: function (err, min) {
        if (err) {
            console.log('Error to minify flutter_service_worker.js. ', err);
        }
    }
});

minify({
    compressor: cleanCSS,
    input: 'build/web/style.css',
    output: 'build/web/style.css',
    callback: function (err, min) {
        if (err) {
            console.log('Error to minify style.css. ', err);
        }
    }
});

minify({
    compressor: htmlMinifier,
    input: 'build/web/404.html',
    output: 'build/web/404.html',
    callback: function (err, min) {
        if (err) {
            console.log('Error to minify 404.html. ', err);
        }
    }
});

minify({
    compressor: htmlMinifier,
    input: 'build/web/index.html',
    output: 'build/web/index.html',
    callback: function (err, min) {
        if (err) {
            console.log('Error to minify index.html. ', err);
        }
    }
});

minify({
    compressor: jsonminify,
    input: 'build/web/assets/assets/i18n/en.json',
    output: 'build/web/assets/assets/i18n/en.json',
    callback: function (err, min) {
        if (err) {
            console.log('Error to minify en.json. ', err);
        }
    }
});
minify({
    compressor: jsonminify,
    input: 'build/web/assets/assets/i18n/es.json',
    output: 'build/web/assets/assets/i18n/es.json',
    callback: function (err, min) {
        if (err) {
            console.log('Error to minify es.json. ', err);
        }
    }
});
minify({
    compressor: jsonminify,
    input: 'build/web/assets/assets/i18n/pt.json',
    output: 'build/web/assets/assets/i18n/pt.json',
    callback: function (err, min) {
        if (err) {
            console.log('Error to minify pt.json. ', err);
        }
    }
});